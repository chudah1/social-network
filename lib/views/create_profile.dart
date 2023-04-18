import 'package:flutter/material.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:social_network/models/user.dart';

class ProfileForm extends StatefulWidget {
  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  //global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  bool _campusResidence = false;

  String _idNumber = "";
  String _name = "";
  String _email = "";
  String _major = "";
  String _food = "";
  String _movie = "";
  String _dateOfBirth = "";
  final _yearGroup = DateTime.now().year;

  void _createProfile() async {
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
      await _userController.createUser(userCreated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 450,
        margin: EdgeInsets.all(50.0),
        color: Colors.amberAccent,
        child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: TextFormField(
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
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
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Enter your year group",
                      label: Text("Year Group"),
                      prefixIcon: Icon(Icons.date_range)),
                ),
                TextFormField(
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
                    value: _campusResidence,
                    onChanged: ((value) {
                      setState(() {
                        _campusResidence = value!;
                      });
                    })),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                      onPressed: _createProfile,
                      icon: Icon(Icons.app_registration),
                      label: Text("Submit")),
                )
              ],
            )),
      ),
    ));
  }
}
