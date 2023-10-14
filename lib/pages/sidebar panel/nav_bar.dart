// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/auth/main_page.dart';
import 'package:flutter_application_cst9l/pages/collection_page.dart';
import 'package:flutter_application_cst9l/pages/home_page.dart';
import 'package:flutter_application_cst9l/pages/items/details_page.dart';
import 'package:flutter_application_cst9l/pages/items/profile_page.dart';
import 'package:flutter_application_cst9l/util/fooduser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final givenuser = FirebaseAuth.instance.currentUser!;
    final name = givenuser.displayName;

    return Drawer(
      backgroundColor: Color(0xFF78e08f),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(givenuser.email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/UserProfile.png'),
              radius: 40,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/Logo2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // TAB 1
          ListTile(
            leading: Icon(
              Icons.menu_book,
              color: Colors.black,
            ),
            title: Text('Home Page', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            title: Text('Profile', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.black,
            ),
            title: Text('Collection', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CollectionPage()));
            },
          ),

          // TAB 3
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            title: Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
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
                    Expanded(
                      child: Text(
                        'Logout Successfully',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1500),
                elevation: 30,
                padding: EdgeInsets.all(40),
                shape: StadiumBorder(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
