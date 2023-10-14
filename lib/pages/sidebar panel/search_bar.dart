// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/pages/home_page.dart';
import 'package:flutter_application_cst9l/pages/items/details_page.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_price1.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_price2.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_star1.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_star2.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_star3.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_star4.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_star5.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_type1.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_type2.dart';
import 'package:flutter_application_cst9l/pages/items/homepages/home_type3.dart';
import 'package:flutter_application_cst9l/pages/sidebar%20panel/nav_bar.dart';
import 'package:flutter_application_cst9l/util/foodreview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('FoodReview');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3A47),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo2.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(5.0),
                child: Text('Bite and Share'))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterAll(),
            SizedBox(
              height: 15,
            ),
            Text(
              'Ratings',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 15,
            ),
            FilterRating(),
            SizedBox(
              height: 15,
            ),
            Text(
              'Types of Food',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 15,
            ),
            FilterTypes(),
            SizedBox(
              height: 15,
            ),
            Text(
              'Prices of Food',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 15,
            ),
            FilterPrice(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget FilterAll() => InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Container(
          width: 60,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFF53917E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                'All',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      );

  Widget FilterRating() => SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 35,
          runSpacing: 24,
          children: [
            // 1 STAR
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeStar1()));
              },
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // 2 STAR
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeStar2()));
              },
              child: Container(
                width: 80,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // 3 STAR
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeStar3()));
              },
              child: Container(
                width: 100,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // 4 STAR
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeStar4()));
              },
              child: Container(
                width: 120,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // 5 STAR
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeStar5()));
              },
              child: Container(
                width: 140,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget FilterTypes() => SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 15,
          children: [
            // MAIN DISH
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeType1()));
              },
              child: Container(
                width: 110,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'Main Dish',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // SIDE DISH
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeType2()));
              },
              child: Container(
                width: 110,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'Side Dish',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // DESSERT DISH
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeType3()));
              },
              child: Container(
                width: 100,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'Dessert',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget FilterPrice() => SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: [
            // Low Price
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePrice1()));
              },
              child: Container(
                width: 170,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'Low Prices (999 below)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // HIGH PRICE
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePrice2()));
              },
              child: Container(
                width: 180,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF53917E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'High Prices (1000 above)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
