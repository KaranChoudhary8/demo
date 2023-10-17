import 'package:expense/CustomW/custom_input.dart';
import 'package:expense/Provider/date_time.dart';
import 'package:expense/Provider/radio_picker.dart';
import 'package:expense/Provider/add_amount_provider.dart';
import 'package:expense/Settings/constaint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAmountDetails extends StatefulWidget {
  const AddAmountDetails({super.key});

  @override
  State<AddAmountDetails> createState() => _AddAmountDetailsState();
}

class _AddAmountDetailsState extends State<AddAmountDetails> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(26.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Balance",
                      style: TextStyle(fontSize: 36),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyInput(
                      label: "Ammount",
                      hint: "200",
                      icon: Icons.money,
                      controller: amount,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyInput(
                      label: "Description",
                      hint: "Description",
                      icon: Icons.info,
                      keyBoard: TextInputType.text,
                      controller: title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Type",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Consumer<RadioPicker>(builder: (context, value, child) {
                          return Expanded(
                              child: RadioListTile<amountType>(
                            value: amountType.Earning,
                            title: const Text("Earning"),
                            groupValue: value.type,
                            onChanged: (val) {
                              value.setType(val!);
                            },
                          ));
                        }),
                        Consumer<RadioPicker>(builder: (context, value, child) {
                          return Expanded(
                              child: RadioListTile<amountType>(
                            value: amountType.Expense,
                            title: const Text("Expense"),
                            groupValue: value.type,
                            onChanged: (val) {
                              value.setType(val!);
                            },
                          ));
                        }),
                      ],
                    ),
                    Consumer<DateTimeProvider>(
                        builder: (context, value, child) {
                      dateController.text = value.date;
                      return TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_month),
                            labelText: "Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (pickedDate != null) {
                            String dateFormat =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            value.setDate(dateFormat);
                          }
                        },
                      );
                    }),
                    Consumer<DateTimeProvider>(
                        builder: (context, value, child) {
                      timeController.text = value.time;
                      return TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.timer_rounded), labelText: "Date"),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (pickedTime != null) {
                            String timeFormat =
                                "${pickedTime.hour}:${pickedTime.minute}";
                          }
                        },
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<AddAmountProvider>(
                        builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: () {
                          if (amount.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please Enter Amount")));
                          } else {
                            final radio = Provider.of<RadioPicker>(context,
                                listen: false);
                            value.addData(
                                amount.text,
                                title.text,
                                radio.type,
                                dateController.text,
                                timeController.text,
                                context);
                            Navigator.pop(context);
                          }
                        },
                        child: value.isLoading
                            ? CircularProgressIndicator(color: Colors.white,)
                            : Text("ADD"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                      );
                    }),
                  ])),
        ),
      ),
    );
  }
}
