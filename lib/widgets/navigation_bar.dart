import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
      
            SizedBox(
              width: 150,
              height: 80,
              child: Image.asset('assets/images/ashesi.jpg'),
            ),
          ],
        ));
  }
}

class _NavBarItem extends StatelessWidget {
  //declare attributes
  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.yellow),
    );
  }
}
