// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/pages/items/profile_page.dart';
import 'package:flutter_application_cst9l/pages/sidebar%20panel/nav_bar.dart';
import 'package:flutter_application_cst9l/util/foodreview.dart';
import 'package:flutter_application_cst9l/util/fooduser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({
    super.key,
    required this.users,
  });

  final FoodUsers users;

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final double coverHeight = 200;
  final double profileHeight = 144;
  late DateTime date = DateTime.now();
  late FocusNode fName, fDate, fPhone, fEmail, fPassword;

  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.users.name,
    );
    dateController = TextEditingController(
      text: widget.users.date,
    );
    phoneController = TextEditingController(
      text: widget.users.phone,
    );
    emailController = TextEditingController(
      text: widget.users.email,
    );
    passwordController = TextEditingController(
      text: widget.users.password,
    );
    fName = FocusNode();
    fDate = FocusNode();
    fPhone = FocusNode();
    fEmail = FocusNode();
    fPassword = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fName.dispose();
    fDate.dispose();
    fPhone.dispose();
    fEmail.dispose();
    fPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Profile Page'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            SizedBox(
              height: 80,
            ),
            // ENTER PROFILE NAME
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextField(
                controller: nameController,
                focusNode: fName,
                decoration: InputDecoration(
                  icon: Icon(Icons.menu_book_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Enter Recipe Name',
                ),
              ),
            ),
            // ENTER PROFILE DATE
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextField(
                controller: dateController,
                focusNode: fDate,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Enter Date',
                  suffixIcon: MaterialButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (newDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('yyyy/MM/dd').format(newDate);
                        });
                      }
                    },
                    child: Text('Select Date'),
                  ),
                ),
              ),
            ),
            // ENTER PROFILE PHONE
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
                controller: phoneController,
                focusNode: fPhone,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.length < 11) {
                    return 'Enter min. 11 characters';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Enter Phone Number',
                  hintText: '+639',
                ),
              ),
            ),
            // ENTER PROFILE EMAIL
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
                controller: emailController,
                focusNode: fEmail,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid Email'
                        : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Enter Email',
                ),
              ),
            ),
            // ENTER PROFILE PASSWORD
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
                controller: passwordController,
                focusNode: fPassword,
                validator: (value) {
                  if (value != null && value.length < 7) {
                    return 'Enter min. 7 characters';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Enter Password',
                ),
              ),
            ),
            // BUTTON FOR UPDATE
            Container(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  final isValidForm = formKey.currentState!.validate();
                  if (isValidForm) {
                    updateUser(widget.users.id);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // BUTTON FOR BACK
            Container(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.black,
        child: Image(
          image: AssetImage('assets/images/Logo2.png'),
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage('assets/images/UserProfile.png'),
      );

  updateUser(String id) async {
    if (nameController.text.trim() == "") {
      fName.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (dateController.text.trim() == "") {
      fDate.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (phoneController.text.trim() == "") {
      fPhone.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (emailController.text.trim() == "") {
      fEmail.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (passwordController.text.trim() == "") {
      fPassword.requestFocus();
      showFailedSnackBar();
      return false;
    } else {
      final docUser = FirebaseFirestore.instance.collection('Users').doc(id);
      docUser.update({
        'name': nameController.text,
        'date': dateController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });

      // String email2 = emailController.text;
      // String password2 = passwordController.text;
      // final UserFood = await FirebaseAuth.instance.currentUser;
      // UserFood!.updateEmail(email2);
      // UserFood.updatePassword(password2);
      // FirebaseAuth.instance.userChanges();
      // AuthCredential credential = EmailAuthProvider.credential(
      //     email: emailController.text, password: passwordController.text);
      // await UserFood.reauthenticateWithCredential(credential);
      // await FirebaseAuth.instance.currentUser!.reload();
      // final user = await FirebaseAuth.instance.currentUser!;

      showSuccessSnackBar();
      Navigator.pop(context);
    }
  }

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: const [
          Icon(
            Icons.thumb_up,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Successfully Updated the Recipe',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: Duration(milliseconds: 1500),
      elevation: 30,
      padding: EdgeInsets.all(30),
      shape: StadiumBorder(),
    ));
  }

  void showFailedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: const [
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'There is an empty field check carefully',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: Duration(milliseconds: 1500),
      elevation: 30,
      padding: EdgeInsets.all(30),
      shape: StadiumBorder(),
    ));
  }
}
