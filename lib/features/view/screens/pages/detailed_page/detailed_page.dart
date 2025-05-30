import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/services/favorite_service.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/book_now_sheet.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/about_benefits.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/detailed_app_bar.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/detailed_bottom.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/detailed_header.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/event_details.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/event_pic.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/organizer_panel.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/organizer_detail_page.dart';

class DetailedPage extends StatefulWidget {
  final UserDataModel userData;
  final PostDataModel post;
  const DetailedPage({super.key, required this.post, required this.userData});

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchOrganizerDetails(uid: widget.post.uid));
    checkFavoriteStatus();

    log(widget.post.uid);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void checkFavoriteStatus() async {
    isFavorite = await FavoritesService.isFavorite(
      widget.userData.uid,
      widget.post.postId,
    );
    setState(() {});
  }

  void toggleFavorite() async {
    if (isFavorite) {
      await FavoritesService.removeFromFavorites(
        widget.userData.uid,
        widget.post.postId,
      );
    } else {
      await FavoritesService.addToFavorites(widget.userData.uid, widget.post);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  OrganizerDataModel? organizerData;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is OrganizerGet) {
          setState(() {
            organizerData = state.organizerData;
          });
          log(organizerData.toString());
        } else if (state is BookNowState) {
          // showBookingSheet(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder:
                (context) => BookNowSheet(
                  organizer: organizerData!,
                  tickets: widget.post.tickets,
                  userData: widget.userData,
                  organizerUid: organizerData!.uid,
                  post: widget.post,
                ),
          );
        }
      },
      child: Scaffold(
        appBar: DetailedAppBar(
          onFavoriteToggle: toggleFavorite,
          isFavorite: isFavorite,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventPic(pic: widget.post.imageUrl),
              DetailedHeader(group: widget.post.group, name: widget.post.name),
              organizerData != null
                  ? OrganizerPanel(
                    organizerData: organizerData!,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => OrganizerDetailPage(
                                organizerData: organizerData!,
                              ),
                        ),
                      );
                    },
                  )
                  : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
              EventDetails(
                category: widget.post.category,
                date: widget.post.registrationDeadline,
                venue: widget.post.venue,
                country: widget.post.country,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutBenefits(
                    about: widget.post.description,
                    benefits: widget.post.benefits,
                  ),
                  SizedBox(height: 20),

                  //ApplyCoupon(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: DetailedBottom(
          numberOfVariants: widget.post.tickets.length,
          onPressed: () {
            context.read<PostBloc>().add(BookNowBtn());
          },
        ),
      ),
    );
  }
}
