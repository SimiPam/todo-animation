import 'package:animated_login_fb_app/screens/auth/auth.dart';
import 'package:animated_login_fb_app/screens/auth/wrapper.dart';
import 'package:animated_login_fb_app/services/auth_service.dart';
import 'package:animated_login_fb_app/utils/themes.dart';
import 'package:animated_login_fb_app/widgets/sign_in_up_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'config/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  children: [Icon(Icons.error), Text("something went wrong")],
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
              StreamProvider<User>.value(
                value: AuthServices().user,
                initialData: null,
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              // theme: myTheme,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: GoogleFonts.montserratTextTheme(),
                accentColor: Palette.darkOrange,
                appBarTheme: const AppBarTheme(
                  brightness: Brightness.dark,
                  color: Palette.darkBlue,
                ),
              ),
              home: Wrapper(),
            ),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: LoadingIndicator(isLoading: true),
              ),
            ),
          );
        }
      },
    );
  }
}
