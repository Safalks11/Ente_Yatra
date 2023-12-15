import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:main_project/controller/firebase_helper/firebase_helper.dart';
import 'package:main_project/view/login%20and%20registration/login.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box('userBox');
    final username = userBox.get('user')?['username'] ?? 'Default User';
    final email = userBox.get('user')?['email'] ?? 'Default Email';

    return Drawer(
      child: Column(
        children: [
          buildDrawerHeader(username, email),
          Expanded(
            child: buildDrawerItems(context),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerHeader(String username, String email) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 275,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildUserAvatar(),
          buildSocialIcons(),
          buildUserInfo(username, email),
        ],
      ),
    );
  }

  Widget buildUserAvatar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
              "https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?s=612x612&w=0&k=20&c=QjebAlXBgee05B3rcLDAtOaMtmdLjtZ5Yg9IJoiy-VY="),
        ),
      ),
    );
  }

  Widget buildSocialIcons() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue[900]!),
          buildSocialIcon(FontAwesomeIcons.instagram, Colors.pink),
          buildSocialIcon(FontAwesomeIcons.twitter, Colors.blueAccent),
          buildSocialIcon(FontAwesomeIcons.google, Colors.red),
        ],
      ),
    );
  }

  Widget buildSocialIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FaIcon(icon, color: color),
    );
  }

  Widget buildUserInfo(String username, String email) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            username,
            style:
                GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          email,
          style: GoogleFonts.aBeeZee(fontSize: 10),
        ),
      ],
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.pink.shade50]),
      ),
      child: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          children: [
            buildListTile(Icons.dark_mode_outlined, "Change Theme",
                () => _showThemeDialog(context)),
            buildSizedBox(15),
            buildListTile(Icons.favorite, "Favourite", () {}),
            buildSizedBox(15),
            buildListTile(Icons.help, "Help & Support", () {}),
            buildSizedBox(15),
            buildListTile(Icons.settings, "Settings", () {}),
            buildSizedBox(15),
            buildListTile(Icons.add_reaction, "Invite a friend", () {}),
            buildSizedBox(15),
            buildListTile(Icons.logout, "Logout", () {
              Get.dialog(AlertDialog(
                title: Text(
                  "Do you want to logout?",
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseHelper().logout().then((value) {
                            handleLogout();
                          });
                        },
                        child: Text("Logout"))
                  ],
                ),
              ));
            }),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(IconData leadingIcon, String title, Function() onTap) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      leading: Icon(leadingIcon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 15),
    );
  }

  Widget buildSizedBox(double height) {
    return SizedBox(height: height);
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildElevatedButton("Dark Theme", () {
                Get.changeTheme(ThemeData.dark());
                Navigator.of(context).pop(); // Close the dialog
              }),
              buildElevatedButton("Light Theme", () {
                Get.changeTheme(ThemeData.light());
                Navigator.of(context).pop(); // Close the dialog
              }),
            ],
          ),
        );
      },
    );
  }

  Widget buildElevatedButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  void handleLogout() {
    final userBox = Hive.box('userBox');
    userBox.delete('user');
    Get.offAll(LoginScreen());
    Get.snackbar("Logged out!!", "You have logged out...");
  }
}
