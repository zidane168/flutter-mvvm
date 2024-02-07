import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mvvm/data/services/user_service.dart';
import 'package:mvvm/routes/routes.dart';
import 'package:mvvm/view/user_screen.dart';
import 'package:mvvm/view_models/user_view_model.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main()  {
  final dio = Dio();
  final userService = UserService(dio: dio);
  Get.put(UserViewModel(userService: userService));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GetMaterialApp(
      title: "INIT",
      localizationsDelegates: [

        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            fallbackFile: 'en',
            basePath: 'assets/locales',
          ),
          missingTranslationHandler: (key, locale) {
            print('Missing translation: $key for locale: $locale');
          },
        ),

        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [ // https://api.flutter.dev/flutter/flutter_localizations/kMaterialSupportedLanguages.html
        Locale('en'),
        Locale('vi'),
        Locale('hk'),   // hong kong
        // Locale('cn', 'CN'),   // china
      ],
      locale: const Locale('en' ), // Set the fallback locale
      fallbackLocale: const Locale('en' ), // Set the fallback locale
      onGenerateTitle: (BuildContext context) => FlutterI18n.translate(context, "title"),
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),

      initialRoute: MyRoutes.getHomeRoute(),
      getPages: MyRoutes.routes,

      home: UserScreen(),
    );
  }

}
