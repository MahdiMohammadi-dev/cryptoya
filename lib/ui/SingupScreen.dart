import 'package:cryptoya/network/ResponseModel.dart';
import 'package:cryptoya/providers/UserProvider.dart';
import 'package:cryptoya/ui/HomePage.dart';
import 'package:cryptoya/ui/MainWrapper.dart';
import 'package:cryptoya/ui/Widgets/HomePageView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              ///TODO:For Over 600 Width
              return SingleChildScrollView(
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotatedBox(
                              quarterTurns: 3,
                              child: Lottie.asset(
                                  'assets/images/bitcointouch.json',
                                  fit: BoxFit.fill)),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 30,),
                            // Lottie.asset('images/bitcointouch.json',height: height * 0.3,fit: BoxFit.fill),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text('Sign Up',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: height * 0.035,
                                      color: Theme.of(context)
                                          .unselectedWidgetColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text('Create Account',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: height * 0.03,
                                      color: Theme.of(context)
                                          .unselectedWidgetColor)),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, bottom: 20),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person),
                                        hintText: 'Username',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                      controller: namecontroller,
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter username';
                                        } else if (value.length < 4) {
                                          return 'at least enter 4 characters';
                                        } else if (value.length > 13) {
                                          return 'maximum character is 13';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    TextFormField(
                                      controller: emailcontroller,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_rounded),
                                        hintText: 'gmail',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter gmail';
                                        } else if (!value
                                            .endsWith('@gmail.com')) {
                                          return 'please enter valid gmail';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    TextFormField(
                                      controller: passwordcontroller,
                                      obscureText: isObsecure,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock_open),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isObsecure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isObsecure = !isObsecure;
                                            });
                                          },
                                        ),
                                        hintText: 'Password',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        } else if (value.length < 7) {
                                          return 'at least enter 6 characters';
                                        } else if (value.length > 13) {
                                          return 'maximum character is 13';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          height: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Consumer<UserProvider>(builder:
                                        (context, userDataProvider, child) {
                                      switch (userDataProvider
                                          .registerstatus?.status) {
                                        case Status.Loading:
                                          return const CircularProgressIndicator();
                                        case Status.Completed:
                                          // savedLogin(userDataProvider.registerStatus?.data);
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback((timeStamp) =>
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MainWrapper())));
                                          return singUpBtn();
                                        case Status.Error:
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              singUpBtn(),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.error,
                                                    color: Colors.redAccent,
                                                  ),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    userDataProvider
                                                        .registerstatus!
                                                        .message,
                                                    style: GoogleFonts.ubuntu(
                                                        color: Colors.redAccent,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        default:
                                          return singUpBtn();
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            const Align(
                                alignment: Alignment.center,
                                child: Text('Already have an account?')),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.blue, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen()));
                                  },
                                  child: const Text('Login'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              ///TODO:For Mobile Screen
              return SingleChildScrollView(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
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
              );
            }
          },
        ));
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ));
          }
        },
      ),
    );
  }
}
