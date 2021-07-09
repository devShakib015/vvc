import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/utils/error_page.dart';
import 'package:vvc/utils/loading_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VVC',
      debugShowCheckedModeBanner: false,
      theme: VvcStyle.vvcTheme(context),
      defaultTransition: Transition.rightToLeftWithFade,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorPage();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return VVC();
          }

          return LoadingPage();
        },
      ),
    );
  }
}

class VVC extends StatelessWidget {
  final StorageController _storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return _storageController.isOnBoardingShown ? AuthView() : OnBoardingView();
  }
}
