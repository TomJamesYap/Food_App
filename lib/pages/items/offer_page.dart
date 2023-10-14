import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            // FIRST CARD
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // IMAGE OF THE CARD
                    InkWell(
                      onTap: () {
                        print('You have selected this image');
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Main_Dish.jpg',
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                    // THE DETAILS OF THE IMAGE
                    Expanded(
                      child: Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Beef Tapa',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'This is only a sample text',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SECOND CARD
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // IMAGE OF THE CARD
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Side_Dish.jpg',
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                    // THE DETAILS OF THE IMAGE
                    Expanded(
                      child: Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Utan',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'This is only a sample text',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // THIRD CARD
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // IMAGE OF THE CARD
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Dessert_Dish.jpg',
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                    // THE DETAILS OF THE IMAGE
                    Expanded(
                      child: Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Mango Float',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'This is only a sample text',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // FOURTH CARD
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // IMAGE OF THE CARD
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Main_Dish.jpg',
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                    // THE DETAILS OF THE IMAGE
                    Expanded(
                      child: Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Beef Tapa',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'This is only a sample text',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // FIFTH CARD
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // IMAGE OF THE CARD
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Side_Dish.jpg',
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                    // THE DETAILS OF THE IMAGE
                    Expanded(
                      child: Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Utan',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'This is only a sample text',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (index) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
