import 'package:flutter/material.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/features/view/screens/pages/blog_page/widgets/blog_tile.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: StreamServices().getBlog(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: StyleText(text: 'No Blogs Posted'));
            }
            final blogs = snapshot.data!;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogTile(blogData: blog);
              },
            );
          },
        ),
      ),
    );
  }
}
