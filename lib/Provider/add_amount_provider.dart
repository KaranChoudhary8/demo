import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense/Settings/amountModel.dart';
import 'package:expense/Settings/constaint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAmountProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool option) {
    _isLoading = option;
    notifyListeners();
  }

  Future<List<AmountModel>> getRecords() async {
    final _db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString();

    final snapshot = await _db
        .collection("Users")
        .doc(uid)
        .collection("Transactions")
        .get();
    final recordList =
        snapshot.docs.map((e) => AmountModel.fromSnapshot(e)).toList();
    return recordList;
  }

  void addData(String amount, String? title, amountType type, String date,
      String time, var context) {
    setLoading(true);
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString();
    print(uid);
    if (uid != null) {
      final _db = FirebaseFirestore.instance;
      // _db.collection("Users/"+uid!+"/Transactions").add
      if (title == null || title == "") {
        title = "Unknown";
      }
      AmountModel model = AmountModel(
          amount: amount,
          type: type.toString(),
          date: date,
          time: time,
          title: title);
      // _db.collection("Users/${uid}/Transactions/${date}_${time}")
      _db
          .collection("Users")
          .doc(uid)
          .collection("Transactions")
          .add(model.toJson())
          .whenComplete(() => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Success"))))
          .catchError(() => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went Wrong"))));
      setLoading(false);
      notifyListeners();
    } else {
      print("Error");
    }

    // int amountInt = amount as int;
    // DateTime dataDate = DateTime.parse(date);
    // String folderName = DateFormat('MMM').format(dataDate) + DateFormat('yyyy').format(dataDate);
    // _db.collection("User/${uid}/MonthlyData/${folderName}").
  }
}
