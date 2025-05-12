import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/organizer_list_page/organizer_page_tile.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerListPage extends StatelessWidget {
  const OrganizerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Organizer List',
        color: themeColor,
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: StreamServices().getOrganizerHome(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Center(
                child: StyleText(text: 'No Organizer registered'),
              );
            }

            final organizers = snapshot.data!;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: organizers.length,
              itemBuilder: (context, index) {
                return OrganizerPageTile(organizerData: organizers[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
