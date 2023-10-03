import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isObsecure = true;

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LottieBuilder.asset(
              'assets/images/waveloop.json',
              height: height * 0.2,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Sign Up",
                style: GoogleFonts.ubuntu(
                    fontSize: height * 0.035,
                    color: Theme.of(context).unselectedWidgetColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Create Account",
                style: GoogleFonts.ubuntu(
                  fontSize: height * 0.03,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        controller: namecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter The Username...!";
                          } else if (value.length < 4) {
                            return "At Least 4 Charachter for Username";
                          } else if (value.length > 13) {
                            return 'Maximum length of username is 13 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Colors.grey,
                            ),
                            hintText: "Email Address",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        controller: emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter The Email Address...!";
                          } else if (value.endsWith("@gmail.com")) {
                            return "Please Enter The Valid Email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        obscureText: isObsecure,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  setState(() {
                                    isObsecure = !isObsecure;
                                  });
                                },
                                child: Icon(
                                  isObsecure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                )),
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            hintText: "Password",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter The Password...!";
                          } else if (value.length < 4) {
                            return "At Least 4 Charachter for Password";
                          } else if (value.length > 13) {
                            return 'Maximum length of username is 13 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        "The Creating Account That Means you Accept the \n Term of Services and our Privacy and Policy",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      singUpBtn(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget singUpBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        child: Text("SignUp"),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            print("The SignUp is Correcred");
          }
        },
      ),
    );
  }
}
