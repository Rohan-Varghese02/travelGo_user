import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_app_bar.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_live_update.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_post_list.dart';
import 'package:travelgo_user/features/view/widgets/heading_text.dart';
import 'package:travelgo_user/features/view/widgets/long_button.dart';
import 'package:travelgo_user/features/view/widgets/profile_avatar.dart';

class OrganizerDetailPage extends StatefulWidget {
  final OrganizerDataModel organizerData;
  const OrganizerDetailPage({super.key, required this.organizerData});

  @override
  State<OrganizerDetailPage> createState() => _OrganizerDetailPageState();
}

class _OrganizerDetailPageState extends State<OrganizerDetailPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
  }

  Future<void> checkIfFollowing() async {
    final userId = auth.currentUser?.uid;
    if (userId == null) return;

    final doc =
        await firestore
            .collection('Users')
            .doc(userId)
            .collection('following')
            .doc(widget.organizerData.uid)
            .get();

    setState(() {
      isFollowing = doc.exists;
    });
  }

  Future<void> toggleFollow() async {
    final userId = auth.currentUser?.uid;
    final organizerId = widget.organizerData.uid;

    if (userId == null) return;

    final userFollowRef = firestore
        .collection('Users')
        .doc(userId)
        .collection('following')
        .doc(organizerId);

    final organizerRef = firestore.collection('Organizers').doc(organizerId);

    if (isFollowing) {
      // for Unfollow
      await userFollowRef.delete();
      await organizerRef.update({'followers': FieldValue.increment(-1)});
    } else {
      //for Follow
      await userFollowRef.set({
        'name': widget.organizerData.name,
        'imageUrl': widget.organizerData.imageUrl,
        'uid': organizerId,
      });
      await organizerRef.update({'followers': FieldValue.increment(1)});
    }

    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrganizerAppBar(organizerData: widget.organizerData),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAvatar(url: widget.organizerData.imageUrl),
              const SizedBox(height: 10),
              OrganizerLiveUpdate(organizerData: widget.organizerData),
              const SizedBox(height: 10),
              HeadingText(text: 'Events Hosted', color: themeColor),
              const SizedBox(height: 10),
              OrganizerPostList(organizerData: widget.organizerData),
            ],
          ),
        ),
      ),
      floatingActionButton: LongButton(
        text: isFollowing ? 'Unfollow' : 'Follow',
        onPressed: toggleFollow,
        color: white,
      ),
    );
  }
}
