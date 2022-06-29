import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobil_muhasebe/Widget/confirm_dialog.dart';
import 'package:mobil_muhasebe/Widget/info_snackbar.dart';
import 'package:mobil_muhasebe/add_transaction.dart';
import 'package:mobil_muhasebe/controllers/db_helper.dart';
import 'package:mobil_muhasebe/model/transaction.dart';
import 'package:mobil_muhasebe/static.dart' as Static;
import 'package:shared_preferences/shared_preferences.dart';

import '../Widget/myDrawe.dart';

class rapor extends StatefulWidget {
  const rapor({Key? key}) : super(key: key);

  @override
  _raporState createState() => _raporState();
}

class _raporState extends State<rapor> {
  //
  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;

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

  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('money');
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      // return Future.value(box.toMap());
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        // print(element);
        items.add(
          TransactionModel(
            element['amount'] as int,
            element['note'],
            element['date'] as DateTime,
            element['type'],
          ),
        );
      });
      return items;
    }
  }
  //

  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData) {
      if (item.date.month == today.month && item.type == "Gider") {
        tempdataSet.add(item);
      }
    }
    //
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }

  getTotalBalance(List<TransactionModel> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (TransactionModel data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Gelir") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }
///////////// APPBAR /////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gelir - Gider - Rapor"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Colors.blueAccent,
                Colors.blueGrey,
              ],
            ),
          ),
        ),
      ),

      /////////// SOL MENÜ //////////////

      drawer: MyDrawer(),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            CupertinoPageRoute(
              builder: (context) => AddExpenseNoGradient(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add_outlined,
          size: 32.0,
          color: Colors.white,
        ),
      ),
      //
      body: FutureBuilder<List<TransactionModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Bir Hata Oluştu!",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "Sistemde hiç veri yok.",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              );
            }
            //
            getTotalBalance(snapshot.data!);
            getPlotPoints(snapshot.data!);
            return ListView(
              children: [
                /////////// TABLONUN RENKLERİ ///////////
                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Colors.blueAccent,
                                      Colors.lightBlue,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //
                selectMonth(),

                ///////// TOPLAM MİKTAR KISMI /////////////
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.all(
                    12.0,
                  ),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.blueAccent,
                          Colors.blueGrey,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        // color: Static.PrimaryColor,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Toplam Miktar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              // fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            ' $totalBalance TL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 38.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(
                                  totalIncome.toString(),
                                ),
                                cardExpense(
                                  totalExpense.toString(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                ///////////// GRAFİK /////////////////


                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Text(
                    "${months[today.month - 1]} ${today.year}",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //
                dataSet.isEmpty || dataSet.length < 2
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 40.0,
                          horizontal: 20.0,
                        ),
                        margin: EdgeInsets.all(
                          12.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "Grafik için yeterli veri bulunmamaktadır.",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    : Container(
                        height: 400.0,
                        padding: EdgeInsets.symmetric(
                          vertical: 40.0,
                          horizontal: 12.0,
                        ),
                        margin: EdgeInsets.all(
                          12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: LineChart(
                          LineChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                // spots: getPlotPoints(snapshot.data!),
                                spots: getPlotPoints(snapshot.data!),
                                isCurved: false,
                                barWidth: 2.5,
                                showingIndicators: [200, 200, 90, 10],
                                dotData: FlDotData(
                                  show: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                //////// SON İŞLEMLER ////////////
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Son işlemler:",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    TransactionModel dataAtIndex;
                    try {
                      dataAtIndex = snapshot.data![index];
                    } catch (e) {

                      return Container();
                    }

                    if (dataAtIndex.date.month == today.month) {
                      if (dataAtIndex.type == "Gelir") {
                        return incomeTile(
                          dataAtIndex.amount,
                          dataAtIndex.note,
                          dataAtIndex.date,
                          index,
                        );
                      } else {
                        return expenseTile(
                          dataAtIndex.amount,
                          dataAtIndex.note,
                          dataAtIndex.date,
                          index,
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                //
                SizedBox(
                  height: 60.0,
                ),
              ],
            );
          } else {
            return Text(
              "Yükleniyor...",
            );
          }
        },
      ),
    );
  }

  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.blue,
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gelir",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gider.",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget expenseTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "Uyarı",
          "Kayıt silinecek. Bu işlem geri döndürülemez. Onaylıyor musunuz ?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xffced4eb),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_up_outlined,
                          size: 28.0,
                          color: Colors.red[700],
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Gider",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "${date.day} ${months[date.month - 1]} ",
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "- $value",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        note,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "Uyarı!",
          "Kayıt silinecek. Bu işlem geri döndürülemez. Onaylıyor musunuz ?",
        );

        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xffced4eb),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_down_outlined,
                      size: 28.0,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Gelir",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${date.day} ${months[date.month - 1]} ",
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                //
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+ $value",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    note,
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


//////////// ÜSTEKİ AYLAR ///////////////


  Widget selectMonth() {
    return Padding(
      padding: EdgeInsets.all(
        8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                index = 3;
                today = DateTime(now.year, now.month - 2, today.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 3 ? Colors.blue : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 3],
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  color: index == 3 ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 2;
                today = DateTime(now.year, now.month - 1, today.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 2 ? Colors.blueAccent : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 2],
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  color: index == 2 ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 1;
                today = DateTime.now();
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 1 ? Colors.blueAccent : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 1],
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  color: index == 1 ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
