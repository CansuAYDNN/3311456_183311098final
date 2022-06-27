import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';
import 'package:mobil_muhasebe/controllers/db_helper.dart';

class AddExpenseNoGradient extends StatefulWidget {
  const AddExpenseNoGradient({Key? key}) : super(key: key);

  @override
  _AddExpenseNoGradientState createState() => _AddExpenseNoGradientState();
}

class _AddExpenseNoGradientState extends State<AddExpenseNoGradient> {
  DateTime selectedDate = DateTime.now();
  int? amount;
  String note = "Kullanılan.";
  String type = "Alınan.";

  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(""),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.blueGrey, Colors.white]),
            ),
          ),
        ),
        backgroundColor: Color(0xffe2e7ef),
        //
        body: ListView(
          padding: EdgeInsets.all(
            12.0,
          ),
          children: [
            Text(
              "\n Yeni girdi ekle.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900]),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.unarchive_rounded,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "0 kg",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    onChanged: (val) {
                      try {
                        amount = int.parse(val);
                      } catch (e) {
                        // show Error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(
                              seconds: 2,
                            ),
                            content: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  "Yalnızca rakam giriniz!!",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    // textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.vaccines_outlined,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Türü",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    onChanged: (val) {
                      note = val;
                    },
                  ),
                ),
              ],
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.unfold_less_sharp,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Alınan",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Alınan" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Colors.green,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Alınan";
                        if (note.isEmpty || note == "Kullanılan") {
                          note = 'Alınan';
                        }
                      });
                    }
                  },
                  selected: type == "Alınan" ? true : false,
                ),
                SizedBox(
                  width: 8.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Kullanılan",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Kullanılan" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Colors.green,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Kullanılan";

                        if (note.isEmpty || note == "Alınan") {
                          note = 'Kullanılan';
                        }
                      });
                    }
                  },
                  selected: type == "Kullanılan" ? true : false,
                ),
              ],
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  _selectDate(context);
                  //
                  // to make sure that no keyboard is shown after selecting Date
                  FocusScope.of(context).unfocus();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.zero,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        12.0,
                      ),
                      child: Icon(
                        Icons.date_range,
                        size: 24.0,
                        // color: Colors.grey[700],
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 60.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  if (amount != null) {
                    DbHelper dbHelper = DbHelper();
                    dbHelper.addData(amount!, selectedDate, type, note);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[700],
                        content: Text(
                          "Lütfen Geçerli Bir Miktar Girin !",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "Ekle",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}