import 'package:get_it/get_it.dart';
import 'package:skin_firts/core/services/api_services.dart';
import 'package:skin_firts/core/services/hive_auth_services.dart';
import 'package:skin_firts/core/theme/theme_provider.dart';
import 'package:skin_firts/feature/appointment/presentation/view_model/appointment_view_model.dart';
import 'package:skin_firts/feature/authentication/Application/auth_services.dart';
import 'package:skin_firts/feature/authentication/data/auth_repository_impl.dart';
import 'package:skin_firts/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:skin_firts/feature/authentication/presentation/view_model/auth_view_model.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/view_model/doctor_view_model.dart';
import 'package:skin_firts/feature/homePage/presentation/view_model/home_page_view_model.dart';

// This is our global service locator
final locator = GetIt.instance;

Future<void> setupLocator() async {
  // ---------------------------------------------------------
  // 1. Core / Services (The lowest level)
  // ---------------------------------------------------------
  // LazySingleton means it only creates the object the first time it's asked for.
  locator.registerLazySingleton<ApiServices>(() => ApiServices());
  locator.registerLazySingleton<AuthServices>(() => AuthServices());
  locator.registerLazySingleton<HiveAuthServices>(() => HiveAuthServices());

  // ---------------------------------------------------------
  // 2. Repositories
  // ---------------------------------------------------------
  // Notice how we tell get_it to find the services it needs automatically using locator()
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localAuthServices: locator<HiveAuthServices>(),
      apiServices: locator<AuthServices>(),
    ),
  );

  // ---------------------------------------------------------
  // 3. ViewModels (State Management)
  // ---------------------------------------------------------
  locator.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  locator.registerLazySingleton<HomePageViewModel>(() => HomePageViewModel());
  
  // Injecting ApiServices directly via locator()
  locator.registerLazySingleton<AppointmentViewModel>(
    () => AppointmentViewModel(apiServices: locator<ApiServices>()),
  );
  
  locator.registerLazySingleton<DoctorViewModel>(
    () => DoctorViewModel(apiServices: locator<ApiServices>()),
  );

  // ⚠️ Architecture Tip: ViewModels should usually take a Repository, not a Service directly.
  // Assuming you update AuthViewModel to take AuthRepository later, it would look like this:
  locator.registerLazySingleton<AuthViewModel>(
    () => AuthViewModel(locator<AuthServices>()), 
  );
}