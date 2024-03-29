import 'package:shoppingapp/cache/users/models/user_caches_model.dart';
import 'package:shoppingapp/core.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await hiveInitialize();

  // checking route
  // var result = await AutCacheService().getLoginAsync();
  // if (result != null) {
  //   if (AppUserTemp.authCache.userId != 0) {
  //     AppPages.init = AppRoutes.main;
  //   }
  // }
  if (LoginTemp.token.isNotEmpty && LoginTemp.user.id != 0) {
    AppPages.init = AppRoutes.main;
  } else {
    AppPages.init = AppRoutes.onboarding;
  }
   AppPages.init = AppRoutes.main;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Setup StatusBar Colortr
  SystemChrome.setSystemUIOverlayStyle(AppColors.darkSystemUiOverlayStyle);
  runApp(const AppStartup());
}

/// initialize hive
Future<void> hiveInitialize() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(LanguageCacheModelAdapter());
  Hive.registerAdapter(UserCacheModelAdapter());
}
