class FoodReview {
  final String id;
  final String name;
  final String feedback;
  final String image;
  final String rating;
  final String date;
  final double price;
  final String type;

  FoodReview({
    required this.id,
    required this.name,
    required this.feedback,
    required this.image,
    required this.rating,
    required this.date,
    required this.price,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'feedback': feedback,
        'image': image,
        'rating': rating,
        'date': date,
        'price': price,
        'type': type,
      };

  static FoodReview fromJson(Map<String, dynamic> json) => FoodReview(
        id: json['id'],
        name: json['name'],
        feedback: json['feedback'],
        image: json['image'],
        rating: json['rating'],
        date: json['date'],
        price: json['price'],
        type: json['type'],
      );
}
