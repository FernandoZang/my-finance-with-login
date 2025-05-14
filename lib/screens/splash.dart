import 'package:flutter/material.dart';
import 'package:my_finances/main.dart';

class SplashScreenFlutter extends StatefulWidget {
  @override
  _SplashScreenFlutterState createState() => _SplashScreenFlutterState();
}

class _SplashScreenFlutterState extends State with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  var _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 1
    )..forward();

    
    _animation  = CurvedAnimation(parent: _controller, curve: Curves.easeOut);


    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MyHomePage(title: 'Minhas Finanças')),
      );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDay = isItDay();
    var color = isDay? Colors.white : Colors.grey;

    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset('assets/images/logo.png', width: 300)          
        )
      )
    );
  }

  isItDay(){
    var hour = DateTime.now().hour;
    return hour<=18 && hour>=6;
  }
}