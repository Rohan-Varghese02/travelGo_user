import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/detailed_page.dart';
import 'package:travelgo_user/features/view/screens/pages/search_page/widgets/custom_list_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/search_page/widgets/filter_menu.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

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
            Navigator.pop(context); // close the bottom sheet
          },
        );
      },
    );
  }

  // Default search query
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
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

          // StreamBuilder to display posts based on the search query
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
                              builder: (context) => DetailedPage(post: post),
                            ),
                          );
                        },
                        child: CustomListTile(post: post, price: price),
                      );
                      // return ListTile(
                      //   leading: Image(image: NetworkImage(post.imageUrl)),
                      //   title: Text(post.name),
                      //   subtitle: Text(post.description),
                      //   trailing: Text(post.category),
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //         builder: (context) => DetailedPage(post: post),
                      //       ),
                      //     );
                      //   },
                      // );
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
