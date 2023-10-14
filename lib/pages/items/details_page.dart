// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/pages/home_page.dart';
import 'package:flutter_application_cst9l/util/foodreview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.food,
  });

  final FoodReview food;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController nameController;
  late TextEditingController feedbackController;
  late TextEditingController imageController;
  late TextEditingController ratingController;
  late TextEditingController dateController;
  late TextEditingController priceController;
  late TextEditingController typeController;

  PlatformFile? pickedFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.food.name,
    );
    feedbackController = TextEditingController(
      text: widget.food.feedback,
    );
    imageController = TextEditingController(
      text: widget.food.image,
    );
    ratingController = TextEditingController(
      text: widget.food.rating,
    );
    dateController = TextEditingController(
      text: widget.food.date,
    );
    priceController = TextEditingController(
      text: widget.food.price.toString(),
    );
    typeController = TextEditingController(
      text: widget.food.type,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    feedbackController.dispose();
    imageController.dispose();
    ratingController.dispose();
    dateController.dispose();
    priceController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3A47),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  children: [
                    // IMAGE OF THE CARD
                    Container(
                      height: 330,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // image: DecorationImage(
                        //   image: AssetImage('assets/images/Main_Dish.jpg'),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: DisplayPhoto(),
                    ),
                    // THE BLURRY SPOT
                    Positioned(
                      top: 200,
                      child: BlurryContainer(
                        padding: EdgeInsets.all(20),
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xff141921).withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // NAME OF THE RECIPE
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      nameController.text,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // TYPE OF THE RECIPE
                                  Text(
                                    typeController.text,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // RATINGS OF THE RECIPE
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating:
                                            double.parse(ratingController.text),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // BELOW THE IMAGE DETAILS
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DATE OF THE RECIPE
                      Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Reiviewed on ' + dateController.text,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // FEEDBACK OF THE RECIPE
                      Text(
                        'Feedback',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        feedbackController.text,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // PRICE OF THE RECIPE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    r'₱ ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    priceController.text,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // BUTTON FOR BACK
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.green[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imgExist() => Image.file(
        File(pickedFile!.path!),
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );

  Widget imgNotExist() => Image.network(
        widget.food.image,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );

  Widget imgNotExistBlank() => Image.asset(
        'assets/images/no-image.png',
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );

  Widget DisplayPhoto() => Container(
        child: (pickedFile == null) ? imgNotExist() : imgExist(),
      );

  updateUser(String id) {
    final docUser = FirebaseFirestore.instance.collection('FoodReview').doc(id);
    docUser.update({
      'name': nameController.text,
      'feedback': feedbackController.text,
      'image': imageController.text,
      'rating': ratingController.text,
      'date': dateController.text,
      'price': priceController.text,
      'type': typeController.text,
    });
    Navigator.pop(context);
  }
}
