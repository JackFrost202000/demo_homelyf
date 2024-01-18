import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/features/auth/services/auth_service.dart';
import 'package:homelyf_services/features/partner/services/partner_auth_service.dart';
import 'package:homelyf_services/providers/partner_provider.dart';
import 'package:homelyf_services/providers/user_provider.dart';
import 'package:homelyf_services/router.dart';
import 'package:flutter/material.dart';
import 'package:homelyf_services/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PartnerProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  final PartnerAuthService partnerAuthService = PartnerAuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    partnerAuthService.getPartnerData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeLyf Services',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
