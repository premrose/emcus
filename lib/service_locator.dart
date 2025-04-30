import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'network/repositories/auth_repository.dart';
import 'network/services/auth_services.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sl.registerSingleton<FirebaseApp>(firebaseApp);

  // Auth
  sl.registerSingleton<AuthServiceRepository>(AuthServiceImp());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
