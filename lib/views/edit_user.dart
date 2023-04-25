import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/widgets/form_field_widget.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:social_network/models/user.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final String idNumber;
  EditPage({required this.idNumber});

  @override
  State<EditPage> createState() => _EditPageState(idNumber: idNumber);
}

class _EditPageState extends State<EditPage> {
  String idNumber;
  _EditPageState({required this.idNumber});

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

/// This function edits a user's profile and saves the changes.
  void _editProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userEdited = User(
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
      final success = await _userController.editUser(userEdited);

/// The above code is showing an AlertDialog with a title and content based on whether a profile was
/// successfully edited or not. If the profile was edited successfully, the title will be "Success" and
/// the content will be "Profile edited successfully". If the profile was not edited successfully, the
/// title will be "Failure" and the content will be "Failed to edit User". The AlertDialog also has an
/// "OK" button that will dismiss the dialog if the profile was edited successfully.
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xff764abc),
              title: Text(success ? "Success" : "Failure"),
              content: Text(success
                  ? "Profile edited successfully"
                  : "Failed to edit User"),
              actions: [
                TextButton(
                    onPressed: () {
                      if (success) {
                        context.pop();
                      }
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
          title: Title(color: Color(0xff764abc), child: Text("AshNetwork")),
          backgroundColor: Color(0xff764abc),
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
                  children: [Image.asset("assets/images/edit.png")],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 50, top: 10),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          )),
                      FutureBuilder<User>(
                          future: _userController.getUser(idNumber),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }

                            final user = snapshot.data!;
                            return Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(children: [
                                    CustomTextFormField(
                                      initialValue: user.name,
                                      enabled: false,
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
                                      enabled: false,
                                      initialValue: user.idNumber,
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
                                      enabled: false,
                                      initialValue: user.email,
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
                                      initialValue: user.major,
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
                                      initialValue: user.movie,
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
                                      initialValue: user.food,
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
                                      initialValue: "${user.yearGroup}",
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
                                          initialValue: user.dateOfBirth,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: "Date of Birth",
                                            prefixIcon:
                                                Icon(Icons.calendar_month),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onTap: () async {
                                            DateTime? date =
                                                await showDatePicker(
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
                                    onPressed: _editProfile,
                                    icon: const Icon(Icons.mode_edit),
                                    label: const Text("Submit"),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      backgroundColor: Color(0xff764abc),
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )));
  }
}
