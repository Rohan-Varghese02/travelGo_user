import 'package:flutter/material.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/detailed_page.dart';
import 'package:travelgo_user/features/view/screens/pages/search_page/widgets/custom_list_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/search_page/widgets/filter_menu.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class Searchpage extends StatefulWidget {
  final UserDataModel userdata;
  const Searchpage({super.key, required this.userdata});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedCountry;

  void _openFilterMenu() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return FilterMenuWidget(
          selectedCategory: _selectedCategory,
          selectedCountry: _selectedCountry,
          onFilterApply: (category, country) {
            setState(() {
              _selectedCategory = category;
              _selectedCountry = country;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyleText(text: 'Search', fontWeight: FontWeight.bold, size: 30),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by post name',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _openFilterMenu,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<List<PostDataModel>>(
              stream: StreamServices().getFilteredPosts(
                searchQuery,
                category: _selectedCategory,
                country: _selectedCountry,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No posts found'));
                } else {
                  final posts = snapshot.data!;

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final firstTicket = post.tickets.entries.first;
                      int price = firstTicket.value['price']!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailedPage(
                                    post: post,
                                    userData: widget.userdata,
                                  ),
                            ),
                          );
                        },
                        child: CustomListTile(post: post, price: price),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
