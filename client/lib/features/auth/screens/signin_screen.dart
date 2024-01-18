import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homelyf_services/common/widgets/custom_button.dart';
import 'package:homelyf_services/common/widgets/custom_textfield.dart';
import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/features/auth/screens/forgot_password_screen.dart';
import 'package:homelyf_services/features/auth/screens/signup_screen.dart';
import 'package:homelyf_services/features/auth/services/auth_service.dart';
import 'package:homelyf_services/features/partner/screens/signin_partner.dart';

enum Auth { signin, signup }

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _passwordObscured = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signInUser() {
    authService.signInUser(
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
          //   Positioned(
          //   top: -MediaQuery.of(context).size.height / 2, // Position the image above the screen
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height, // Set the full height of the screen
          //     child: Image.asset(
          //       'assets/images/logo.png', // Replace with your image path
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
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
                            key: _signInFormKey,
                            child: Column(
                              children: [
                                const Text(
                                  'Welcome!',
                                  style: TextStyle(
                                    fontSize: 40,
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
                                        return const ForgotPasswordScreen();
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
                                    if (_signInFormKey.currentState!
                                        .validate()) {
                                      signInUser();
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
                                          return const SignUpScreen();
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
                                            return const SignInPartner();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign In As A Service Provider',
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

  String validatePassword(String password) {
    List<String> errors = [];

    // Check for minimum length
    if (password.length < 8) {
      errors.add("at least 8 characters");
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("at least one uppercase letter");
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add("at least one lowercase letter");
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(password)) {
      errors.add("at least one digit");
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*()-_+=<>?/[\]{}|]').hasMatch(password)) {
      errors.add("at least one special character");
    }

    if (password.contains(' ')) {
      errors.add("no spaces");
    }

    if (password.length > 14) {
      errors.add("at most 14 characters");
    }

    // Concatenate error messages
    String errorMessages = errors.join(', ');

    // Return result
    if (errorMessages.isNotEmpty) {
      return "Password must contain $errorMessages.";
    }
    return '';
  }
}
