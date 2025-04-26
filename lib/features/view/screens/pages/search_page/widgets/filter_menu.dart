import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class FilterMenuWidget extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedCountry;

  final Function(String?, String?) onFilterApply;

  const FilterMenuWidget({
    super.key,
    this.selectedCategory,
    this.selectedCountry,
    required this.onFilterApply,
  });

  @override
  State<FilterMenuWidget> createState() => _FilterMenuWidgetState();
}

class _FilterMenuWidgetState extends State<FilterMenuWidget> {
  String? _category;
  String? _country;

  List<String> _categories = [];
  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    _category = widget.selectedCategory;
    _country = widget.selectedCountry;
    _fetchDropdownData();
  }

  Future<void> _fetchDropdownData() async {
    final categorySnapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .where('type', isEqualTo: 'event')
            .get();

    final countrySnapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .where('type', isEqualTo: 'country')
            .get();

    setState(() {
      _categories =
          categorySnapshot.docs.map((doc) => doc['name'].toString()).toList();
      _countries =
          countrySnapshot.docs.map((doc) => doc['name'].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _category,
            decoration: InputDecoration(labelText: 'Category'),
            items:
                _categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
            onChanged: (val) => setState(() => _category = val),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _country,
            decoration: InputDecoration(labelText: 'Country'),
            items:
                _countries
                    .map(
                      (country) => DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      ),
                    )
                    .toList(),
            onChanged: (val) => setState(() => _country = val),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onFilterApply(_category, _country);
            },
            child: StyleText(text: 'Apply Filter'),
          ),
        ],
      ),
    );
  }
}
