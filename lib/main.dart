import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:skin_firts/core/di/locator.dart';
import 'package:skin_firts/core/services/notification_services.dart';
import 'package:skin_firts/core/theme/app_theme.dart';
import 'package:skin_firts/core/theme/theme_provider.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/authentication/presentation/view_model/auth_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/homePage/presentation/view_model/home_page_view_model.dart';
import 'package:skin_firts/feature/onboarding/presentation/pages/SplashScreen.dart';
import 'package:skin_firts/firebase_options.dart';
import 'core/API/api_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationService().init();
  await _setup();
  await setupLocator();
  runApp(
    MultiProvider(
      providers: [
        // Provider<ApiServices>(create: (context) => ApiServices()),
        // ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // ChangeNotifierProvider(create: (context) => HomePageViewModel()),
        // ChangeNotifierProvider(
        //   create:
        //       (context) => AppointmentViewModel(
        //         apiServices: context.read<ApiServices>(),
        //       ),
        // ),
        // ChangeNotifierProvider(
        //   create:
        //       (context) =>
        //           DoctorViewModel(apiServices: context.read<ApiServices>()),
        // ),
        // Provider<AuthServices>(create: (context) => AuthServices()),
        // Provider<AuthRepository>(
        //   create:
        //       (context) => AuthRepositoryImpl(
        //         localAuthServices: HiveAuthServices(),
        //         apiServices: context.read<AuthServices>(),
        //       ),
        // ),
        // ChangeNotifierProvider<AuthViewModel>(
        //   create: (context) => AuthViewModel(context.read<AuthServices>()),
        // ),

        ChangeNotifierProvider(create: (_) => locator<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => locator<HomePageViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<AppointmentViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<DoctorViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<AuthViewModel>()),
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
  await Hive.openBox('settings_box');
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
