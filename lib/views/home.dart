import 'package:flutter/material.dart';
import 'package:social_network/widgets/navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const NavBar(),
            Center(
              child: Column(
                children: <Widget>[
                  SvgPicture.asset("assets/images/friends_svg.svg"),
                  Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Column(
                        children: const <Widget>[
                          Text(
                            "Welcome To The AshNetwork",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Connect with your friends",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(30.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          // padding: EdgeInsets.all(10.0),
                          elevation: 3.0),
                      onPressed: () {
                        context.goNamed("login");
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("Login"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Color(0xff764abc),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(10.0),
                          elevation: 3.0),
                      onPressed: () {
                        context.goNamed("register");
                      },
                      icon: const Icon(Icons.app_registration_rounded),
                      label: const Text("Register"),
                    ),
                  ])
                ],
              ),
            )
          ],
        ));
  }
}
