import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/favorite_service.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/detailed_page.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/wishlist/wishlist_remove_dailog.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';

class WishlistPage extends StatefulWidget {
  final UserDataModel userData;
  const WishlistPage({super.key, required this.userData});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Wishlist',
        color: white,
        center: true,
        backgroundColor: themeColor,
        showBack: true,
      ),
      body: StreamBuilder<List<PostDataModel>>(
        stream: FavoritesService.getFavoritesStream(
          widget.userData.uid,
        ), // Listen to changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No favorites yet."));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: grey50, width: 0.4),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      post.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(post.name),
                    subtitle: Text(post.category),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: redeError),
                      onPressed: () async {
                        wishlistRemoveDailog(
                          context,
                          post.name,
                          widget.userData.uid,
                          post.postId,
                        );
                        // await FavoritesService.removeFromFavorites(
                        //   widget.userData.uid,
                        //   post.postId,
                        // );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => DetailedPage(
                                post: post,
                                userData: widget.userData,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
