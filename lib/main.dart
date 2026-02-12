import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/services/hive_auth_services.dart';
import 'package:skin_firts/core/theme/app_theme.dart';
import 'package:skin_firts/core/theme/theme_provider.dart';
import 'package:skin_firts/feature/authentication/data/auth_repository_impl.dart';
import 'package:skin_firts/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:skin_firts/feature/authentication/presentation/view_model/auth_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/homePage/presentation/view_model/home_page_view_model.dart';
import 'package:skin_firts/feature/onboarding/presentation/pages/SplashScreen.dart';
import 'core/API/api_keys.dart';

void main() async {
  await _setup();
  final authRepo = AuthRepositoryImpl(localAuthServices: HiveAuthServices());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => HomePageViewModel()),
        ChangeNotifierProvider(create: (context) => DoctorViewModel()),
        Provider<AuthRepository>.value(value: authRepo),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(context.read<AuthRepository>()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Hive.initFlutter();
  await Hive.openBox('auth_box');
  await Hive.openBox('current_session');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          home: Splashscreen(),
        );
      },
    );
  }
}
