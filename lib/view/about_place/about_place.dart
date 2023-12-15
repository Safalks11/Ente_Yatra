import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_project/view/about_place/widgets_about.dart';
import 'package:main_project/widgets/background_container.dart';
import '../../data/dummy_data/dummy_data.dart';

class AboutPlacesScreen extends StatefulWidget {
  const AboutPlacesScreen({Key? key}) : super(key: key);

  @override
  State<AboutPlacesScreen> createState() => _AboutPlacesScreenState();
}

class _AboutPlacesScreenState extends State<AboutPlacesScreen> {
  late Map<String, dynamic> detail; // Define detail as a class-level variable
  @override
  Widget build(BuildContext context) {
    final id =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final detail = details.firstWhere((detail) => detail['id'] == id['id']);

    return SafeArea(
      child: BackgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(detail["title"] ?? "", detail["name"] ?? ""),
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildHeader(detail),
                buildDescription(detail),
                buildImage(detail),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Book Nearby Hotels",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
