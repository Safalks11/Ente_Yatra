import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import '../../widgets/rating_icons.dart';

AppBar buildAppBar(String name, String title) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: 80,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    leadingWidth: 80,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.amber[500]),
        shape: MaterialStateProperty.all(const CircleBorder()),
      ),
    ),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
      IconButton(
        onPressed: () {
          _handleShare(name, title);
        },
        icon: const Icon(Icons.share_outlined, size: 25),
      ),
      const SizedBox(width: 15),
    ],
  );
}

Widget buildHeader(Map<String, dynamic> detail) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: 190,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${detail["title"]} -"
                    " ${detail["name"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: buildRatingIcons(detail['rating']),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 70,
            child: VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 110,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(detail["profile"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDescription(Map<String, dynamic> detail) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 15),
          ReadMoreText(
            detail["description"],
            textAlign: TextAlign.left,
            trimMode: TrimMode.Line,
            trimLines: 9,
            trimCollapsedText: "Read more",
            trimExpandedText: "Read less",
            moreStyle: TextStyle(color: Colors.red),
            lessStyle: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    ),
  );
}

Widget buildImage(Map<String, dynamic> detail) {
  return SizedBox(
    height: 230,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(detail["image"]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

// Function to handle the share action
void _handleShare(String title, String name) {
  Share.share(
    '$name - Check out this amazing place: $title', // Customize the share message
    subject: 'Share $name', // Customize the subject
  );
}
