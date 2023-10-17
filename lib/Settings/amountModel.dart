import 'package:cloud_firestore/cloud_firestore.dart';

class AmountModel {
  final String title;
  final String amount;
  final String type;
  final String date;
  final String time;

  const AmountModel({
    this.title = "Unknown",
    required this.amount,
    required this.type,
    required this.date,
    required this.time,
  });

  toJson() {
    return {
      "title": title,
      "amount": amount,
      "type": type.toString(),
      "date": date,
      "time": time
    };
  }

  factory AmountModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AmountModel(
        amount: data["amount"],
        type: data["type"],
        date: data["date"],
        time: data["time"],
        title: data["title"],);
  }
}
