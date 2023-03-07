import 'package:bantuin/pages/test/chattest.dart';
import 'package:bantuin/pages/test/maptest.dart';
import 'package:bantuin/pages/test/test.dart';

import 'package:bantuin/pages/splash.dart';
import 'package:bantuin/pages/get_started.dart';

import 'package:bantuin/pages/on_boardings/tutor_guide.dart';
import 'package:bantuin/pages/on_boardings/tutor_guide_choose.dart';

import 'package:bantuin/pages/on_boardings/customer/ob_customer1.dart';
import 'package:bantuin/pages/on_boardings/customer/ob_customer2.dart';
import 'package:bantuin/pages/on_boardings/customer/ob_customer3.dart';
import 'package:bantuin/pages/on_boardings/customer/ob_customer4.dart';
import 'package:bantuin/pages/on_boardings/customer/ob_customer5.dart';

import 'package:bantuin/pages/on_boardings/helper/ob_helper1.dart';
import 'package:bantuin/pages/on_boardings/helper/ob_helper2.dart';
import 'package:bantuin/pages/on_boardings/helper/ob_helper3.dart';
import 'package:bantuin/pages/on_boardings/helper/ob_helper4.dart';
import 'package:bantuin/pages/on_boardings/helper/ob_helper5.dart';

import 'package:bantuin/pages/auths/reset.dart';
import 'package:bantuin/pages/auths/reset_success.dart';
import 'package:bantuin/pages/auths/sign_up.dart';
import 'package:bantuin/pages/auths/sign_in.dart';
import 'package:bantuin/pages/auths/sign_up_success.dart';
import 'package:bantuin/pages/welcome.dart';

import 'package:bantuin/pages/mainpages/main_page.dart';

import 'package:bantuin/pages/helpupload/create_help.dart';
import 'package:bantuin/shared/constatns.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
  NotificationService.initialize();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    var data = message.data;
    print('Message data: ${data['type']}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification!.body.toString()}');
      print(
          'Message also contained a notification: ${message.notification!.title.toString()}');
    }
    NotificationService.showNotification(message);
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: green1));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // Test 3rd Party
        "/test": (context) => TestPage(),
        "/maptest":(context) => MapTestPage(),
        "/chattest":(context) => ChatTestPage(),
        // Test 3rd Party

        // On Boarding
        "/" :(context) => SplashPage(),
        "/get-started":(context) => GetStartedPage(),
        "/tutor-guide":(context) => TutorGuidePage(),
        "/tutor-guide-choose":(context) => TutorGuideChoosePage(),
        "/ob-helper1":(context) => OBHelper1Page(),
        "/ob-helper2":(context) => OBHelper2Page(),
        "/ob-helper3":(context) => OBHelper3Page(),
        "/ob-helper4":(context) => OBHelper4Page(),
        "/ob-helper5":(context) => OBHelper5Page(),
        "/ob-customer1":(context) => OBCustomer1Page(),
        "/ob-customer2":(context) => OBCustomer2Page(),
        "/ob-customer3":(context) => OBCustomer3Page(),
        "/ob-customer4":(context) => OBCustomer4Page(),
        "/ob-customer5":(context) => OBCustomer5Page(),
        // On Boarding

        // Authentication
        "/sign-in":(context) => SignInPage(),
        "/sign-up":(context) => SignUpPage(),
        "/reset":(context) => ResetPage(),
        "/reset-success":(context) => ResetSuccessPage(),
        "/signup-success":(context) => SignUpSuccessPage(),
        // Authentication

        // Stack Nav
        "/welcome":(context) => WelcomePage(),
        // Stack Nav

        // Main Pages
        "/main":(context) => MainPage(),
        // Main Pages

        // Help Create Pages
        "/create-help":(context) => CreateHelpPage()
      },
    );
  }
}
