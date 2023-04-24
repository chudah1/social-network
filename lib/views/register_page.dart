import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/widgets/form_field_widget.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/widgets/date_form_field.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  String _idNumber = "";
  String _name = "";
  String _email = "";
  String _major = "";
  String _food = "";
  String _movie = "";
  String _dateOfBirth = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int _yearGroup = DateTime.now().year;
  String _password = "";
  bool _campusResidence = true;

  void _createProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userCreated = User(
          idNumber: _idNumber,
          name: _name,
          email: _email,
          dateOfBirth: _dateOfBirth,
          major: _major,
          campusResidence: true,
          yearGroup: _yearGroup,
          movie: _movie,
          food: _food,
          password: _password);
      final success = await _userController.createUser(userCreated);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.purpleAccent,
              title: Text(success ? "Success" : "Failure"),
              content: Text(success
                  ? "Profile created successfully"
                  : "Failed to create User"),
              actions: [
                TextButton(
                    onPressed: () {
                      if (success) {
                        context.goNamed("posts");
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Title(color: Colors.purpleAccent, child: Text("AshNetwork")),
          backgroundColor: Colors.purpleAccent,
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(left: 40, right: 20, top: 10),
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
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
                      const Padding(
                          padding: EdgeInsets.only(bottom: 50, top: 10),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          )),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              CustomTextFormField(
                                hintText: "Name",
                                prefixIcon: Icons.person,
                                onSaved: (value) => _name = value!,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter your Name'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              CustomTextFormField(
                                hintText: "ID",
                                prefixIcon: Icons.perm_identity,
                                onSaved: (value) => _idNumber = value!,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter your idNumber'
                                      : null;
                                },
                              )
                            ]),
                            Row(children: [
                              CustomTextFormField(
                                hintText: "Email",
                                prefixIcon: Icons.email,
                                onSaved: (value) => _email = value!,
                                validator: (value) {
                                  return (value == null ||
                                          value.isEmpty ||
                                          !value.contains("@"))
                                      ? 'Please enter a valid email'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              CustomTextFormField(
                                hintText: "Major",
                                prefixIcon: Icons.school,
                                onSaved: (value) => _major = value!,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter your major'
                                      : null;
                                },
                              )
                            ]),
                            Row(children: [
                              CustomTextFormField(
                                hintText: "Favourite Movie",
                                prefixIcon: Icons.movie,
                                onSaved: (value) => _movie = value!,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter your movie'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              CustomTextFormField(
                                hintText: "Favourite Food",
                                prefixIcon: Icons.food_bank,
                                onSaved: (value) => _food = value!,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter your food'
                                      : null;
                                },
                              )
                            ]),
                            Row(children: [
                              CustomTextFormField(
                                hintText: "YearGroup",
                                prefixIcon: Icons.date_range,
                                onSaved: (value) =>
                                    _yearGroup = int.parse(value!),
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter your yearGroup'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 100,
                                child: SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    initialValue: _dateOfBirth,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "Date of Birth",
                                      prefixIcon: Icon(Icons.calendar_month),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onTap: () async {
                                      DateTime? date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2020),
                                        firstDate: DateTime(1998),
                                        lastDate: DateTime(2030),
                                      );
                                      if (date != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        setState(() {
                                          _dateOfBirth = formattedDate;
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      return (value == null)
                                          ? 'Please enter your date of birth'
                                          : null;
                                    },
                                  ),
                                ),
                              ),
                            ]),
                            Row(children: [
                              CustomTextFormField(
                                hintText: "password",
                                prefixIcon: Icons.password,
                                onSaved: (value) => _password = value!,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter a password'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 100,
                                child: SizedBox(
                                  width: 250,
                                  child: CheckboxListTile(
                                      title: Text("Campus Residence?"),
                                      value: _campusResidence,
                                      onChanged: ((value) {
                                        setState(() {
                                          _campusResidence = value!;
                                        });
                                      })),
                                ),
                              )
                            ]),
                            const SizedBox(
                              height: 0,
                            ),
                            ElevatedButton.icon(
                              onPressed: _createProfile,
                              icon: const Icon(Icons.app_registration),
                              label: const Text("Submit"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                backgroundColor: Colors.purpleAccent,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )));
  }
}
