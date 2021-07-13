import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/utils/error_page.dart';
import 'package:vvc/utils/loading_page.dart';
import 'package:vvc/utils/vvc_multi_language.dart';
import 'package:vvc/views/auth/auth_view.dart';
import 'package:vvc/views/onboarding/onboarding_view.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final StorageController _storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VVC',
      debugShowCheckedModeBanner: false,
      theme: VvcStyle.buildTheme.copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: VvcColors.bgColor,
          elevation: 0,
          centerTitle: true,
          textTheme: VvcStyle.vvcTextTheme(context),
        ),
        textTheme: VvcStyle.vvcTextTheme(context),
        accentColor: VvcColors.bgColor,
      ),
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 500),
      translations: VvcMultiLanguage(),
      locale: vvcLanguages[_storageController.langIndex].locale,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorPage();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return VVC();
          } else
            return LoadingPage();
        },
      ),
    );
  }
}

class VVC extends StatelessWidget {
  final StorageController _storageController = Get.find<StorageController>();

  @override
  Widget build(BuildContext context) {
    return _storageController.isOnBoardingShown ? AuthView() : OnBoardingView();
    //return ErrorPage();
  }
}
