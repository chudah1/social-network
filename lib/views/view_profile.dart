import 'package:flutter/material.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:go_router/go_router.dart';

class ViewProfile extends StatelessWidget {
  final String idNumber;

  const ViewProfile({required this.idNumber});

  @override
  Widget build(BuildContext context) {
    /// `final userController = UserController();` is creating an instance of the `UserController`
    /// class, which is used to fetch user data from a data source. This instance is then used in the
    /// `FutureBuilder` to fetch the user data for the specified `idNumber`.
    final userController = UserController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Image.asset("assets/images/collab.png")],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, top: 200),
                    child: Text(
                      "Student with id $idNumber Profile",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: userController.getUser(idNumber),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Color(0xff764abc),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        final userObj = snapshot.data!;
                        return Column(children: [
                          Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: userObj.email),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              child: Icon(Icons.email),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: userObj.major),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              child: Icon(Icons.school),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  "Class ${userObj.yearGroup}"),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Icon(Icons.date_range),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: userObj.movie),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Icon(Icons.movie),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: userObj.food),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Icon(Icons.food_bank),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: userObj.dateOfBirth),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Icon(Icons.date_range),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: userObj.campusResidence
                                                  ? "On Campus"
                                                  : "Off Campus"),
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Icon(Icons.home),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size.fromHeight(30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      backgroundColor: Color(0xff764abc),
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.all(10.0),
                                      elevation: 3.0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                  label: const Text("Go Back"),
                                )
                              ],
                            ),
                          )
                        ]);
                      },
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
