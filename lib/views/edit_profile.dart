import 'package:flutter/material.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:social_network/models/user.dart';

class EditForm extends StatefulWidget {
  final String idNumber;
  const EditForm({required this.idNumber});

  @override
  State<EditForm> createState() => _EditFormState(idNumber: idNumber);
}

class _EditFormState extends State<EditForm> {
  String idNumber;
  _EditFormState({required this.idNumber});
  final _formKey = GlobalKey<FormState>();
  bool _campusResidence = false;
  String _idNumber = "";
  String _name = "";
  String _email = "";
  String _major = "";
  String _food = "";
  String _movie = "";
  String _dateOfBirth = "";
  int _yearGroup = DateTime.now().year;
  final _editController = UserController();

  void _editProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userCreated = User(
          idNumber: _idNumber,
          name: _name,
          email: _email,
          dateOfBirth: _dateOfBirth,
          major: _major,
          campusResidence: _campusResidence,
          yearGroup: _yearGroup,
          movie: _movie,
          food: _food);
      await _editController.editUser(userCreated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Profile"),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: UserController().getUser(idNumber),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            final user = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: TextFormField(
                              enabled: false,
                              initialValue: user.idNumber,
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Please enter idNumber'
                                    : null;
                              },
                              onSaved: (newValue) => _idNumber = newValue!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your idNumber",
                                  label: Text("idNumber"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              enabled: false,
                              initialValue: user.name,
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Please enter your name'
                                    : null;
                              },
                              onSaved: (newValue) => _name = newValue!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your name",
                                  label: Text("Name"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            initialValue: user.email,
                            validator: (String? value) {
                              return (value == null ||
                                      value.isEmpty ||
                                      !value.contains("@"))
                                  ? 'Please enter a valid email'
                                  : null;
                            },
                            onSaved: (newValue) => _email = newValue!,
                            decoration: const InputDecoration(
                                hintText: "Enter your email",
                                label: Text("email"),
                                prefixIcon: Icon(Icons.email)),
                          ),
                          TextFormField(
                            initialValue: user.major,
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? 'Please enter your major'
                                  : null;
                            },
                            onSaved: (newValue) => _major = newValue!,
                            decoration: const InputDecoration(
                                hintText: "Enter your major",
                                label: Text("Major"),
                                prefixIcon: Icon(Icons.school)),
                          ),
                          TextFormField(
                            initialValue: user.food,
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? 'Please enter your favourite food'
                                  : null;
                            },
                            onSaved: (newValue) => _food = newValue!,
                            decoration: const InputDecoration(
                                hintText: "Enter your favourite food",
                                label: Text("Food"),
                                prefixIcon: Icon(Icons.food_bank)),
                          ),
                          TextFormField(
                            initialValue: user.movie,
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? 'Please enter your favourite movie'
                                  : null;
                            },
                            onSaved: (newValue) => _movie = newValue!,
                            decoration: const InputDecoration(
                                hintText: "Enter your favourite movie",
                                label: Text("Food"),
                                prefixIcon: Icon(Icons.movie)),
                          ),
                          TextFormField(
                            initialValue: "${user.yearGroup}",
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) =>
                                _yearGroup = int.parse(newValue!),
                            decoration: const InputDecoration(
                                hintText: "Enter your year group",
                                label: Text("Year Group"),
                                prefixIcon: Icon(Icons.date_range)),
                          ),
                          TextFormField(
                            initialValue: user.dateOfBirth,
                            keyboardType: TextInputType.datetime,
                            // validator: (String? value) {
                            //   return (value == null || value.isEmpty)
                            //       ? 'Please enter your date of Birth'
                            //       : null;
                            // },
                            decoration: const InputDecoration(
                                hintText: "Enter your date of Birth",
                                label: Text("DOB"),
                                prefixIcon: Icon(Icons.date_range)),
                            onSaved: (newValue) => _dateOfBirth = newValue!,
                          ),
                          CheckboxListTile(
                              title: Text("Campus Residence?"),
                              value: user.campusResidence, 
                              // selected: true,
                              onChanged: ((value) {
                                _campusResidence = !value!;
                                print(_campusResidence);
                                // setState(() {
                                //   _campusResidence = value!;
                                // });
                              })),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                                onPressed: _editProfile,
                                icon: Icon(Icons.app_registration),
                                label: Text("Submit")),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
