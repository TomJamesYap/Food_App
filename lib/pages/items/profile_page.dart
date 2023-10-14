// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/pages/items/profile_edit.dart';
import 'package:flutter_application_cst9l/pages/sidebar%20panel/nav_bar.dart';
import 'package:flutter_application_cst9l/util/fooduser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 200;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Profile Page'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          SizedBox(
            height: 80,
          ),
          read(user.uid),
          SizedBox(
            height: 10,
          ),
          read2(user.uid),
        ],
      ),
    );
  }

  Widget buildContent1(FoodUsers user) => Container(
        child: Column(
          children: [
            Text(
              user.name,
              style: TextStyle(fontSize: 50),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.email,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileEdit(
                        users: user,
                      ),
                    ),
                  );
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
          ],
        ),
      );

  Widget buildContent2(FoodUsers user) => Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Name:'),
                  Spacer(),
                  Text(user.name),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Date of birth:'),
                  Spacer(),
                  Text(user.date),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Phone number:'),
                  Spacer(),
                  Text(user.phone),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email: '),
                  Spacer(),
                  Text(user.email),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Password: '),
                  Spacer(),
                  Text(user.password),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );

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

  Widget read(uid) {
    var collection = FirebaseFirestore.instance.collection('Users');
    return Column(
      children: [
        SizedBox(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: collection.doc(uid).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final users = snapshot.data!.data();
                final newUser = FoodUsers(
                  id: users!['id'],
                  name: users['name'],
                  phone: users['phone'],
                  date: users['date'],
                  password: users['password'],
                  email: users['email'],
                );

                return buildContent1(newUser);
              }

              return const Center(
                child: SpinKitThreeInOut(
                  color: Colors.green,
                  size: 80.0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget read2(uid) {
    var collection = FirebaseFirestore.instance.collection('Users');
    return Column(
      children: [
        SizedBox(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: collection.doc(uid).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final users2 = snapshot.data!.data();
                final newUser2 = FoodUsers(
                  id: users2!['id'],
                  name: users2['name'],
                  phone: users2['phone'],
                  date: users2['date'],
                  password: users2['password'],
                  email: users2['email'],
                );

                return buildContent2(newUser2);
              }

              return const Center(
                child: SpinKitThreeInOut(
                  color: Colors.green,
                  size: 80.0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
