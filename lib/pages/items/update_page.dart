import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cst9l/util/foodreview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class Update extends StatefulWidget {
  const Update({
    super.key,
    required this.food,
  });

  final FoodReview food;

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late DateTime date = DateTime.now();
  late double userRating = 3.0;
  late FocusNode fImage, fName, fPrice, fType, fDate, fRate, fDes;
  late String imgUrl;
  late String error;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  late TextEditingController nameController;
  late TextEditingController feedbackController;
  late TextEditingController imageController;
  late TextEditingController ratingController;
  late TextEditingController dateController;
  late TextEditingController priceController;
  late TextEditingController typeController;

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
    fImage = FocusNode();
    fName = FocusNode();
    fPrice = FocusNode();
    fType = FocusNode();
    fDate = FocusNode();
    fRate = FocusNode();
    fDes = FocusNode();
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
    fImage.dispose();
    fName.dispose();
    fPrice.dispose();
    fType.dispose();
    fDate.dispose();
    fRate.dispose();
    fDes.dispose();
    super.dispose();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Future uploadFile() async {
    final path = 'Review/${generateRandomString(8)}';
    print('update path Link: $path');
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      setState(() {
        uploadTask = ref.putFile(file);
      });
    } on FirebaseException catch (e) {
      setState(() {
        error = e.message.toString();
      });
    }

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('update Download Link: $urlDownload');

    updateReview(widget.food.id, urlDownload);

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Feedback'),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 20,
          top: 15,
        ),
        child: GestureDetector(
          onTap: () {},
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    // IMAGE FORMAT
                    Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                      ),
                      child: (pickedFile == null) ? imgNotExist() : imgExist(),
                    ),
                    // POSITIONED BUTTON
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.green[200]),
                        child: IconButton(
                          onPressed: () {
                            selectFile();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // ENTER RECIPE NAME
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
              // ENTER PRICE NAME
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextField(
                  controller: priceController,
                  focusNode: fPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.price_change_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Enter Price of Recipe',
                    hintText: '250.0',
                  ),
                ),
              ),
              // ENTER TYPE NAME
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextField(
                  controller: typeController,
                  focusNode: fType,
                  decoration: InputDecoration(
                    icon: Icon(Icons.type_specimen_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Enter Type of Recipe',
                    hintText: 'Main Dish, Side Dish, Dessert',
                  ),
                ),
              ),
              // ENTER DATE
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
              // ENTER RECIPE RATING
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextField(
                  controller: ratingController,
                  focusNode: fRate,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.rate_review),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Enter Ratings',
                      suffixIcon: MaterialButton(
                        onPressed: () {
                          userRating = double.parse(ratingController.text);
                          setState(() {});
                        },
                        child: Text('Rate'),
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                child: RatingBarIndicator(
                    rating: double.parse(ratingController.text),
                    itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    itemCount: 5,
                    itemSize: 40.0,
                    direction: Axis.horizontal),
              ),
              // ENTER RECIPE FEEDBACK
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: feedbackController,
                  focusNode: fDes,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.format_list_bulleted),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Enter Feedback',
                  ),
                ),
              ),
              // BUTTON FOR UPDATE
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    (pickedFile != null)
                        ? uploadFile()
                        : updateNoReview(widget.food.id);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Update Feedback',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // BUTTON FOR DELETE
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    _showActionSheet(widget.food.id);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Delete Feedback',
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
      ),
    );
  }

  updateReview(String id, String image) {
    if (nameController.text.trim() == "") {
      fName.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (priceController.text.trim() == "") {
      fPrice.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (typeController.text.trim() == "") {
      fType.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (dateController.text.trim() == "") {
      fDate.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (ratingController.text.trim() == "") {
      fRate.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (feedbackController.text.trim() == "") {
      fDes.requestFocus();
      showFailedSnackBar();
      return false;
    } else {
      final docUser =
          FirebaseFirestore.instance.collection('FoodReview').doc(id);
      docUser.update({
        'name': nameController.text,
        'feedback': feedbackController.text,
        'image': image,
        'rating': ratingController.text,
        'date': dateController.text,
        'price': priceController.text,
        'type': typeController.text,
      });
      showSuccessSnackBar();
      Navigator.pop(context);
    }
  }

  updateNoReview(String id) {
    if (nameController.text.trim() == "") {
      fName.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (priceController.text.trim() == "") {
      fPrice.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (typeController.text.trim() == "") {
      fType.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (dateController.text.trim() == "") {
      fDate.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (ratingController.text.trim() == "") {
      fRate.requestFocus();
      showFailedSnackBar();
      return false;
    } else if (feedbackController.text.trim() == "") {
      fDes.requestFocus();
      showFailedSnackBar();
      return false;
    } else {
      final docUser =
          FirebaseFirestore.instance.collection('FoodReview').doc(id);
      docUser.update({
        'name': nameController.text,
        'feedback': feedbackController.text,
        'rating': ratingController.text,
        'date': dateController.text,
        'price': double.parse(priceController.text),
        'type': typeController.text,
      });
      showSuccessSnackBar();
      Navigator.pop(context);
    }
  }

  deleteUser(String id) {
    final docUser = FirebaseFirestore.instance.collection('FoodReview').doc(id);
    docUser.delete();
    Navigator.pop(context);
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

  Widget checkImgVal() {
    return (widget.food.image == '-') ? imgNotExistBlank() : imgNotExist();
  }

  _showActionSheet(String id) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Confirmation'),
        message: const Text(
            'Are you sure you want to delete this user? Doing this will not undo any changes.'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              deleteUser(id);
              showSuccessSnackBar2();
              Navigator.pop(context);
            },
            child: const Text('Continue'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
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

  void showSuccessSnackBar2() {
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
            'Successfully Deleted the Recipe',
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
