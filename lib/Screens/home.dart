import 'package:expense/Provider/add_amount_provider.dart';
import 'package:expense/Provider/fetch_record.dart';
import 'package:expense/Settings/amountModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense/Screens/add_amount.dart';
import 'package:provider/provider.dart';

import '../CustomW/myText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<AddAmountProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: Text("My Balance"), actions: [
        GestureDetector(
          child: Icon(Icons.logout),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: AlertDialog(
                      title: Text("Are you Sure you went to logout"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth.signOut();
                              Navigator.pop(context);
                            },
                            child: Text("Logout")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"))
                      ],
                    ),
                  );
                });
          },
        )
      ]),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 38.0),
                  child: Column(
                    children: [
                      MyText(
                        text: "This Month",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          MyText(
                            text: "Expense: ",
                          ),
                          MyText(
                            text: "3000",
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          MyText(
                            text: "Earning: ",
                          ),
                          MyText(
                            text: "3000",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Recent",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(

                  child: ListView.builder(itemBuilder: (context, index) => ,)
                  child: FutureBuilder(
                      future: listProvider.getRecords(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            // AmountModel model = snapshot.data as AmountModel;

                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.4)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("model.title"),
                                      Text("model.amount")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // children: [Text(snapshot.data["date"] as String), Text(snapshot.data["type"] as String)],
                                    // children: [Text(model.date), Text(model.type)],
                                  ),
                                ]),
                              ),
                            );
                          } else {
                            return Center(child: Text("Nothing to show"));
                          }
                        }
                        else {
                          return Center(child: Text("Nothing to show"));
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAmountDetails()));
          },
          child: Icon(Icons.add)),
    );
  }
}
