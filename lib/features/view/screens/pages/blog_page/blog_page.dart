import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/features/view/screens/pages/blog_page/widgets/blog_tile.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBar(
          title: 'Blogs',
          color: themeColor,
          center: true,
          backgroundColor: white,
        ),
        body:
            userId == null
                ? const Center(child: Text("User not logged in"))
                : StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userId)
                          .collection('following')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final followingOrganizerIds =
                        snapshot.data!.docs.map((doc) => doc.id).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ButtonsTabBar(
                            borderColor: white,
                            backgroundColor: themeColor,
                            unselectedBackgroundColor: white,
                            unselectedLabelStyle: TextStyle(color: black),
                            labelStyle: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                            ),
                            borderWidth: 0,
                            radius: 25,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            tabs: const [
                              Tab(text: 'All'),
                              Tab(text: 'Following'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildBlogStream(null),
                              _buildBlogStream(followingOrganizerIds),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildBlogStream(List<String>? filterOrganizerIds) {
    return StreamBuilder(
      stream: StreamServices().getBlog(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: StyleText(text: 'No Blogs Posted'));
        }

        final allBlogs = snapshot.data!;
        final filteredBlogs =
            filterOrganizerIds == null
                ? allBlogs
                : allBlogs
                    .where(
                      (blog) => filterOrganizerIds.contains(blog.organizerUID),
                    )
                    .toList();

        if (filteredBlogs.isEmpty) {
          return Center(child: StyleText(text: 'No Follow Blogs Found'));
        }

        return ListView.builder(
          itemCount: filteredBlogs.length,
          itemBuilder: (context, index) {
            final blog = filteredBlogs[index];
            return BlogTile(blogData: blog);
          },
        );
      },
    );
  }
}
