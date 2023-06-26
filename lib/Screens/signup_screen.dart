import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Constants/CircularProgress.dart';
import 'package:for_rent/Firebase/Auth/signup.dart';
import 'package:for_rent/Screens/login_screen.dart';
import 'package:for_rent/Themes/theme_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  Widget? w;
  File? photo;

  TextEditingController firstnameEditingController = TextEditingController();
  TextEditingController lastnameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Join to us',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          controller: firstnameEditingController,
                          decoration: ThemeHelper().textInputDecoration(
                              'First Name', 'Enter your first name'),
                          validator: (val) {
                            if ((val!.isEmpty) || (val.length < 5)) {
                              return "Enter a valid name";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          controller: lastnameEditingController,
                          decoration: ThemeHelper().textInputDecoration(
                              'Last Name', 'Enter your last name'),
                          validator: (val) {
                            if ((val!.isEmpty) || (val.length < 5)) {
                              return "Enter a valid name";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          controller: emailEditingController,
                          decoration: ThemeHelper().textInputDecoration(
                              "E-mail address", "Enter your email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if ((val!.isEmpty) ||
                                !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(val)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          controller: phoneEditingController,
                          decoration: ThemeHelper().textInputDecoration(
                              "Mobile Number", "Enter your mobile number"),
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if ((val!.isEmpty) ||
                                !RegExp(r"^(\d+)*$").hasMatch(val)) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          controller: passwordEditingController,
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration(
                              "Password", "Enter your password"),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your password";
                            } else if (val.length < 9) {
                              return "Please enter longer password";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              "Register".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                Progress().showLoaderDialog(context);
                                FireAuth().auth(
                                    emailEditingController.text,
                                    passwordEditingController.text,
                                    firstnameEditingController.text,
                                    lastnameEditingController.text,
                                    phoneEditingController.text,
                                    context);
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Text.rich(TextSpan(children: [
                  const TextSpan(text: "have an account? "),
                  TextSpan(
                    text: 'Log in',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
