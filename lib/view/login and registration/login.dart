import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:main_project/controller/firebase_helper/firebase_helper.dart';
import 'package:main_project/controller/form_validation/form_validator.dart';
import 'package:main_project/model/users.dart';
import 'package:main_project/view/home/home_screen.dart';
import 'package:main_project/view/login%20and%20registration/registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _saveUserDataToHive(String email) async {
    final userBox = Hive.box('userBox');
    final existingUser = userBox.get('user') as Map<String, dynamic>?;
    final updatedUser = existingUser != null
        ? User(existingUser['username'], email).toMap()
        : User('', email).toMap();
    await userBox.put('user', updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade50, Colors.pink.shade50])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ],
                          image: DecorationImage(
                            image:
                                AssetImage("assets/bg_images/login&reg_bg.jpg"),
                            fit: BoxFit.cover,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 25.0, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Login Here!!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "E n t e Y a t r a",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: TextFormField(
                        controller: loginEmailController,
                        validator: FormValidator.simpleEmailValidator,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_rounded)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 10),
                      child: TextFormField(
                        controller: loginPassController,
                        validator: FormValidator.validatePassword,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.password_rounded)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                _forgotPassword();
                              },
                              child: const Text("Forgot your password ?"))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                                setState(() {
                                  isLoading = true;
                                });
                                final loginEmail =
                                    loginEmailController.text.trim();
                                final loginPass =
                                    loginPassController.text.trim();
                                FirebaseHelper()
                                    .login(
                                        loginEmail: loginEmail,
                                        loginPass: loginPass)
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (value == null) {
                                    _saveUserDataToHive(loginEmail);
                                    Get.offAll(HomeScreen());
                                    Get.snackbar("Logged in!!",
                                        "You have successfully logged in...",
                                        backgroundColor: Colors.green);
                                  } else {
                                    Get.snackbar("Error", value,
                                        backgroundColor: Colors.red);
                                  }
                                });
                              },
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a user?"),
                        TextButton(
                            onPressed: () {
                              Get.to(() => RegScreen());
                            },
                            child: const Text("Register"))
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Divider(
                                color: Colors
                                    .black // Choose your desired color for the line
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Or"),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Login with")],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              Text(
                                "Google",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(160, 30),
                              backgroundColor: Colors.red[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                              ),
                              Text(
                                "Facebook",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(160, 30),
                              backgroundColor: Colors.blue[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _forgotPassword() async {
    String email = loginEmailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseHelper().resetPassword(email);
        Get.snackbar("Password Reset",
            "A password reset link has been sent to your email.",
            backgroundColor: Colors.green);
      } catch (error) {
        Get.snackbar("Error", error.toString(), backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Error", "Please enter your email first.",
          backgroundColor: Colors.red);
    }
  }
}
