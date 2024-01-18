import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homelyf_services/common/widgets/custom_button.dart';
import 'package:homelyf_services/common/widgets/custom_textfield.dart';
import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/features/auth/screens/signin_screen.dart';
import 'package:homelyf_services/features/partner/screens/forgot_password_partner.dart';
import 'package:homelyf_services/features/partner/screens/signup_partner.dart';
import 'package:homelyf_services/features/partner/services/partner_auth_service.dart';

class SignInPartner extends StatefulWidget {
  static const String routeName = '/signin-partner';
  const SignInPartner({super.key});

  @override
  State<SignInPartner> createState() => _SignInPartnerState();
}

class _SignInPartnerState extends State<SignInPartner>
    with TickerProviderStateMixin {
  final _signInPartnerFormKey = GlobalKey<FormState>();
  final PartnerAuthService partnerAuthService = PartnerAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObscured = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInServiceProvider() {
    partnerAuthService.partnerSignIn(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(-20, 50),
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                alignment: FractionalOffset.topLeft,
                image: AssetImage(
                  'assets/images/paintbrush.png',
                ),
              )),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.5, 0),
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                alignment: FractionalOffset.topRight,
                image: AssetImage(
                  'assets/images/paint.png',
                ),
              )),
            ),
          ),
          // Image.asset(
          //   'assets/images/hello.jpg', // Replace with your image path
          //   fit: BoxFit.cover,
          //   height: MediaQuery.of(context).size.height,
          // ),
          SafeArea(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: const Color.fromARGB(30, 255, 255, 255),
                          child: Form(
                            key: _signInPartnerFormKey,
                            child: Column(
                              children: [
                                const Text(
                                  'Welcome Partner!',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: GlobalVariables.titleColor,
                                  ),
                                ),
                                Text(
                                  'Experience the Art of Homelyf Services, where comfort finds you!',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 37,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        const Color.fromARGB(255, 46, 46, 46),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                ),
                                CustomTextField(
                                  controller: _emailController,
                                  labelText: 'Email Address',
                                  hintText: 'Enter Email Address',
                                  semanticsLabel: 'Buyers Email SignIn Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email Address';
                                    }
                                    // String emailPattern =
                                    //     r'^[a-z0-9\.]+@([a-z0-9]+\.)+[a-z0-9]{2,320}$';
                                    // RegExp regExp = RegExp(emailPattern);

                                    // if (!regExp.hasMatch(value)) {
                                    //   return 'Please enter a valid email address, only contain letters(a-z), number(0-9), and periods(.) are allowed.';
                                    // }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  hintText: 'Enter Password',
                                  semanticsLabel:
                                      'Buyers Password SignIn Input',
                                  obscureText: _passwordObscured,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      icon: Icon(
                                        _passwordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            const Color.fromARGB(136, 0, 0, 0),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordObscured =
                                              !_passwordObscured;
                                        });
                                      },
                                    ),
                                  ),
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                    // String errorMessages = validatePassword(
                                    //     _passwordController.text);
                                    // if (errorMessages.isNotEmpty) {
                                    //   return errorMessages;
                                    // }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const ForgotPasswordPartner();
                                      }));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 62, 62, 62),
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromARGB(255, 62, 62, 62),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  text: 'Sign In',
                                  gradient: GlobalVariables.buttonGradient,
                                  elevation: 8,
                                  onTap: () {
                                    if (_signInPartnerFormKey.currentState!
                                        .validate()) {
                                      signInServiceProvider();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have An Account?",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 95, 94, 94),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SignUpPartner();
                                        }));
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 4),
                                        ),
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: GlobalVariables.titleColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromARGB(255, 96, 173, 211),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // const Text(
                                //   "Or",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     fontWeight: FontWeight.w600,
                                //     color: Color.fromARGB(255, 95, 94, 94),
                                //   ),
                                // ),
                                // const Text(
                                //   "Sign up with social account",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     fontWeight: FontWeight.w600,
                                //     color: Color.fromARGB(255, 95, 94, 94),
                                //   ),
                                // ),
                                const SizedBox(height: 30),
                                Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 230, 239, 254)),
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Adjust the border radius as needed
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SignInScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign In As A User',
                                      style: TextStyle(
                                        color: GlobalVariables.titleColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        // decoration: TextDecoration.underline,
                                        // decorationColor:
                                        //     GlobalVariables.titleColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
