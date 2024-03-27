import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
         body: SliderDrawer(
           key: _key,
           appBar: const SliderAppBar(
            appBarColor: Colors.white,
            title: Text(
              'Drawer',
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.w700
              )
            )
          ),
           slider: Container(color: Colors.black),
           child: Container(color: const Color.fromRGBO(242, 211, 0, 1)),
        )
      );
   }
}