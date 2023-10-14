// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/pages/items/details_page.dart';
import 'package:flutter_application_cst9l/pages/sidebar%20panel/nav_bar.dart';
import 'package:flutter_application_cst9l/pages/sidebar%20panel/search_bar.dart';
import 'package:flutter_application_cst9l/util/foodreview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeStar2 extends StatefulWidget {
  const HomeStar2({super.key});

  @override
  State<HomeStar2> createState() => _HomeStar2State();
}

class _HomeStar2State extends State<HomeStar2> {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('FoodReview');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3A47),
      drawer: NavBar(),
      appBar: AppBar(
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SearchBar()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<List<FoodReview>>(
        stream: readFood(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final foodrevieww = snapshot.data!;
            return ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(15),
              children: foodrevieww.map(buildOffer).toList(),
            );
          } else {
            return const Center(
              child: SpinKitThreeInOut(
                color: Colors.green,
                size: 80.0,
              ),
            );
          }
        },
      ),
    );
  }

  Widget imgExist(img) => Container(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ));

  Widget imgNotExist() => const Icon(
        Icons.account_circle_rounded,
        size: 40,
      );

  Widget buildOffer(FoodReview food) => Column(
        children: [
          // CONTAINER OF THE CARD
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                // IMAGE OF THE CARD
                Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // image: DecorationImage(
                    //   image: Photos(),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: (food.image != "-")
                      ? imgExist(food.image)
                      : imgNotExist(),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME OF THE RECIPE
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          food.name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      // RATING OF THE RECIPE
                      RatingBarIndicator(
                        rating: double.parse(food.rating),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // PRICE OF THE RECIPE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                r'₱ ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                food.price.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          // BUTTON FOR THE DETAILED PAGE
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      food: food,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFF53917E),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      );

  Stream<List<FoodReview>> readFood() => FirebaseFirestore.instance
      .collection('FoodReview')
      .where('rating', isEqualTo: '2')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => FoodReview.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
}
