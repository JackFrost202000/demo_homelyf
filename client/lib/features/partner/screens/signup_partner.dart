import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homelyf_services/common/widgets/custom_button.dart';
import 'package:homelyf_services/common/widgets/custom_textfield.dart';
import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/constants/utils.dart';
import 'package:homelyf_services/features/partner/screens/signin_partner.dart';
import 'package:homelyf_services/features/partner/services/partner_auth_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SignUpPartner extends StatefulWidget {
  static const String routeName = '/signup-partner';
  const SignUpPartner({super.key});

  @override
  State<SignUpPartner> createState() => _SignUpPartnerState();
}

class _SignUpPartnerState extends State<SignUpPartner>
    with TickerProviderStateMixin {
  final _signUpPartnerFormKey = GlobalKey<FormState>();
  final PartnerAuthService partnerAuthService = PartnerAuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  List<Map<String, String>> _selectedServiceCategories = [];
  Future<List<Map<String, String>>>? _allServiceCategories;

  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool _isOtpSent = false;
  bool _isEmailVerified = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();

    // Manually assign choices for testing
    _allServiceCategories = Future.value([
      {'description': 'homelyf cleaning', 'name': 'cleaning'},
      {'description': 'homelyf printing', 'name': 'printing'},
      {'description': 'homelyf gardening', 'name': 'gardening'},
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
  }

  void signUpUser() {
    partnerAuthService.partnerSignUp(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      mobile: _mobileController.text,
      otp: _otpController.text,
      aadharCard: _aadharController.text,
      address: _addressController.text,
      experience: _experienceController.text,
      password: _passwordController.text,
      serviceCategory: _selectedServiceCategories,
    );
  }

  void sendOtp() async {
    bool isOtpSent = await partnerAuthService.partnerSendOTP(
        context, _emailController.text, _mobileController.text);
    setState(() {
      _isOtpSent = isOtpSent; // Set the flag to indicate OTP has been sent
    });
  }

  void verifyEmail() {
    partnerAuthService
        .partnerVerifyOTP(_emailController.text, _otpController.text)
        .then((result) {
      if (result) {
        // Email verification successful
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Verified Successfully"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
        ));
        setState(() {
          _isEmailVerified = true;
          _isOtpSent = false;
        });
      } else {
        // Email verification failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Verification Failed"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(-50, 50),
            child: Container(
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: FractionalOffset.topLeft,
                  image: AssetImage(
                    'assets/images/hammer.png',
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width / 1.2,
                MediaQuery.of(context).size.width / 8),
            child: Container(
              height: MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.width / 4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: FractionalOffset.topRight,
                  image: AssetImage(
                    'assets/images/nail.png',
                  ),
                ),
              ),
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
                    // const Text(
                    //   'Welcome to HomeLyf',
                    //   style: TextStyle(
                    //     fontSize: 50,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.15,
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: const Color.fromARGB(0, 255, 255, 255),
                          child: Form(
                            key: _signUpPartnerFormKey,
                            child: Column(
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(154, 255, 255, 255),
                                  child: const Text(
                                    'Be a Partner',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 145, 203),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  controller: _nameController,
                                  hintText: 'Enter Name',
                                  labelText: 'Name',
                                  semanticsLabel:
                                      'Service Provider Name SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    String namePattern = r'^[a-zA-Z\ ]{1,30}$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter a valid name with a maximum length of 30 characters, only letters(a-z, A-Z) are allowed.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _emailController,
                                  labelText: 'Email Address',
                                  hintText: 'Enter Email Address',
                                  enabled: !_isEmailVerified,
                                  semanticsLabel:
                                      'Service Provider Email SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email Address';
                                    }
                                    String emailPattern =
                                        r'^[a-z0-9\.]+@([a-z0-9]+\.)+[a-z0-9]{2,320}$';
                                    RegExp regExp = RegExp(emailPattern);

                                    if (!regExp.hasMatch(value)) {
                                      _isEmailValid = true;
                                      return 'Please enter a valid email address, only contain letters(a-z), number(0-9), and periods(.) are allowed.';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    String emailPattern =
                                        r'^[a-z0-9\.]+@([a-z0-9]+\.)+[a-z0-9]{2,320}$';
                                    RegExp regExp = RegExp(emailPattern);

                                    if (regExp.hasMatch(value)) {
                                      _isEmailValid = true;
                                      setState(() {
                                        _isOtpSent = false;
                                      });
                                    }
                                  },
                                  suffixIcon: Visibility(
                                    visible: _isEmailValid,
                                    child: _isEmailVerified
                                        ? const Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Icon(
                                              Icons.verified_rounded,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: TextButton(
                                              child: Text(
                                                'Verify',
                                                style: TextStyle(
                                                  color: _isOtpSent
                                                      ? Colors.grey
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (_isEmailValid) {
                                                  sendOtp();
                                                }
                                              },
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _otpController,
                                  labelText: 'OTP',
                                  hintText: 'Enter OTP',
                                  semanticsLabel:
                                      'Service Provider OTP SignUp Input',
                                  visible:
                                      _isOtpSent, // Only show OTP field if OTP has been sent
                                ),
                                Visibility(
                                  visible: _isOtpSent,
                                  child: TextButton(
                                    onPressed: _isOtpSent ? verifyEmail : null,
                                    child: Text(
                                      'Verify Email',
                                      style: TextStyle(
                                        color: _isEmailVerified
                                            ? Colors
                                                .grey // Change the color if OTP has been sent
                                            : Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTextField(
                                  controller: _mobileController,
                                  hintText: 'Enter Mobile Number',
                                  labelText: 'Mobile No.',
                                  semanticsLabel:
                                      'Service Provider Mobile SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Mobile No.';
                                    }
                                    String namePattern = r'^[0-9\ ]{1,10}$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter a valid mobile no.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FutureBuilder<List<Map<String, String>>>(
                                  future: _allServiceCategories,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              List<Map<String, String>>
                                                  categories = snapshot.data!;
                                              List<
                                                      MultiSelectItem<
                                                          Map<String, String>>>
                                                  items = categories
                                                      .map(
                                                        (category) =>
                                                            MultiSelectItem<
                                                                Map<String,
                                                                    String>>(
                                                          category,
                                                          category['name']!,
                                                        ),
                                                      )
                                                      .toList();

                                              List<Map<String, String>>?
                                                  result = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return MultiSelectDialog(
                                                    items: items,
                                                    initialValue:
                                                        _selectedServiceCategories,
                                                  );
                                                },
                                              );

                                              if (result != null) {
                                                setState(() {
                                                  _selectedServiceCategories =
                                                      result;
                                                });
                                              }
                                            },
                                            style: ButtonStyle(
                                              elevation: MaterialStateProperty
                                                  .all<double>(0),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color.fromARGB(
                                                          255, 247, 250, 255)),
                                              shape: MaterialStateProperty.all<
                                                  OutlinedBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 218, 234, 254),
                                                  ), // Adjust the border radius as needed
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty
                                                  .all<Size>(
                                                const Size(double.infinity,
                                                    58), // Set the button height
                                              ),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Select Service Categories',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 119, 123, 130),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                // CustomTextField(
                                //   controller: _selectedServiceCategories,
                                //   hintText: 'Select Service Categories',
                                //   labelText: 'Service Categories',
                                //   semanticsLabel:
                                //       'Service Provider Categories SignUp Input',
                                //   customValidator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'Please Select Service Categories';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _aadharController,
                                  hintText: 'Enter Aadhar No.',
                                  labelText: 'Aadhar No.',
                                  semanticsLabel:
                                      'Service Provider Aadhar No. SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Aadhar No.';
                                    }
                                    String namePattern = r'^[0-9\ ]{1,12}$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter a valid Aadhar No.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _addressController,
                                  hintText: 'Enter Address',
                                  labelText: 'Address',
                                  semanticsLabel:
                                      'Service Provider Address SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Address';
                                    }
                                    String namePattern = r'[a-zA-Z0-9\ .,/]$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter a valid Address';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _experienceController,
                                  hintText: 'Enter Years of Experience',
                                  labelText: 'Years of Experience',
                                  semanticsLabel:
                                      'Service Provider Years of Experience SignUp Input',
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Years of Experience';
                                    }
                                    String namePattern = r'^[0-9\ ]{1,2}$';
                                    RegExp regExp = RegExp(namePattern);

                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter your experience in years.';
                                    }

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
                                      'Service Provider Password SignUp Input',
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
                                    String errorMessages = validatePassword(
                                        _passwordController.text);
                                    if (errorMessages.isNotEmpty) {
                                      return errorMessages;
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  controller: _confirmPasswordController,
                                  labelText: 'Confirm Password',
                                  hintText: 'Re-enter Password',
                                  semanticsLabel:
                                      'Service Provider Password SignUp Input',
                                  obscureText: _passwordObscured,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      icon: Icon(
                                        _confirmPasswordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            const Color.fromARGB(136, 0, 0, 0),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _confirmPasswordObscured =
                                              !_confirmPasswordObscured;
                                        });
                                      },
                                    ),
                                  ),
                                  customValidator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Re-enter Password';
                                    }
                                    String errorMessages = validatePassword(
                                        _passwordController.text);
                                    if (errorMessages.isNotEmpty) {
                                      return errorMessages;
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                  text: 'Sign Up',
                                  gradient: GlobalVariables.buttonGradient,
                                  elevation: 8,
                                  onTap: () {
                                    if (!_isEmailVerified) {
                                      return showSnackBar(context,
                                          'Please verify Email Address');
                                    } else if (_signUpPartnerFormKey
                                        .currentState!
                                        .validate()) {
                                      signUpUser();
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
                                      'Already Have An Account?',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 95, 94, 94),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SignInPartner();
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
                                        'Sign In',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 96, 173, 211),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromARGB(255, 96, 173, 211),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: TextButton(
                                //     child: const Text(
                                //       'Sign Up As A Buyer',
                                //       style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w500,
                                //         color: GlobalVariables.secondaryColor,
                                //       ),
                                //     ),
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) {
                                //             return const SignUpScreen();
                                //           },
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
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
