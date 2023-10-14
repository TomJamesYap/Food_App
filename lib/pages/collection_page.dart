// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/pages/items/add_page.dart';
import 'package:flutter_application_cst9l/pages/items/update_page.dart';
import 'package:flutter_application_cst9l/pages/sidebar%20panel/nav_bar.dart';
import 'package:flutter_application_cst9l/util/foodreview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Recipe Reviewed'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Add(),
                ),
              );
            },
            icon: const Icon(Icons.add_circle),
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
              children: foodrevieww.map(buildUser).toList(),
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

  Widget imgExist(img) => CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(img),
      );

  Widget imgNotExist() => const Icon(
        Icons.account_circle_rounded,
        size: 40,
      );

  Widget buildUser(FoodReview food) => Column(
        children: [
          Card(
            color: Colors.green[200],
            child: ListTile(
              leading:
                  (food.image != "-") ? imgExist(food.image) : imgNotExist(),
              title: Text(
                food.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: RatingBarIndicator(
                rating: double.parse(food.rating),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Update(
                        food: food,
                      ),
                    ),
                  );
                },
              ),
              dense: true,
              contentPadding: EdgeInsets.all(15.0),
            ),
          ),
        ],
      );

  Stream<List<FoodReview>> readFood() => FirebaseFirestore.instance
      .collection('FoodReview')
      .orderBy('rating', descending: true)
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
