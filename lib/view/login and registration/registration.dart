import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:main_project/controller/firebase_helper/firebase_helper.dart';
import 'package:main_project/controller/form_validation/form_validator.dart';
import 'package:main_project/model/users.dart';
import 'login.dart'; // Assuming you have a LoginScreen class in a file named login.dart

class RegScreen extends StatefulWidget {
  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final regUserNameController = TextEditingController();
  final regEmailController = TextEditingController();
  final regPassController = TextEditingController();
  final regConfPassController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    final String username = regUserNameController.text.trim();
    final String email = regEmailController.text.trim();

    final userBox = Hive.box('userBox');
    final user = User(username, email);

    // Save the user to Hive
    await userBox.put('user', user.toMap());

    // After successful registration, you can navigate to the next screen or perform other actions.
    print('Registration successful');
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
              colors: [Colors.blue.shade50, Colors.pink.shade50],
            ),
          ),
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
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                        image: DecorationImage(
                          image:
                              AssetImage("assets/bg_images/login&reg_bg.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 25.0, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Text(
                                  "Register Here!!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "E n t e Y a t r a",
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 15),
                      child: TextFormField(
                        controller: regUserNameController,
                        validator: FormValidator.validateName,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                          prefixIcon: Icon(Icons.password_rounded),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: TextFormField(
                        validator: FormValidator.simpleEmailValidator,
                        textInputAction: TextInputAction.next,
                        controller: regEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: TextFormField(
                        validator: FormValidator.validatePassword,
                        controller: regPassController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          helperText:
                              "Password length must contain 6 characters",
                          prefixIcon: Icon(Icons.password_rounded),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: TextFormField(
                        validator: (value) =>
                            FormValidator.validateConfirmPassword(
                                value, regPassController.text),
                        textInputAction: TextInputAction.next,
                        controller: regConfPassController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.confirmation_number_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                                final regEmail = regEmailController.text.trim();
                                final regPass =
                                    regConfPassController.text.trim();
                                FirebaseHelper()
                                    .register(
                                        regEmail: regEmail, regPass: regPass)
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (value == null) {
                                    Get.to(LoginScreen());
                                    Get.snackbar(
                                      "Registered",
                                      "You have registered Successfully",
                                      backgroundColor: Colors.green,
                                    );
                                    _register();
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
                                "Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I have an account ?"),
                        TextButton(
                          onPressed: () {
                            Get.to(() => LoginScreen());
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
