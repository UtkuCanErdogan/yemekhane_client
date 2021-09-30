
import 'package:client/view/home/view/home_view.dart';
import 'package:client/view/home/view/home_view_2.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[routeObserver],
      title: 'Yemekhane Demo',
      theme: ThemeData(
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states){
            if (states.contains(MaterialState.selected)) {
              return Colors.white; // the color when checkbox is selected;
            }
            return Colors.white;
          })
        ),
        primaryColor: Colors.red,
      ),
      home: HomeView2(),
    );
  }
}

