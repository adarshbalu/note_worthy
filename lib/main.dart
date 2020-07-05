import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_worthy/data/database.dart';
import 'package:note_worthy/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note Worthy',
        theme: ThemeData(
          textTheme: TextTheme().merge(GoogleFonts.poppinsTextTheme()),
          appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              color: Colors.white,
              elevation: 0,
              textTheme: TextTheme().copyWith(
                  headline5: TextStyle(color: Colors.white),
                  headline6: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.grey,
          fontFamily: GoogleFonts.poppins().toString(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
