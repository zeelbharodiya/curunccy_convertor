import 'package:currency_convertor/views/screens/models/currency_convert.dart';
import 'package:currency_convertor/views/screens/models/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helpers/api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<Curency?> getData;

  final formKey = GlobalKey<FormState>();
  TextEditingController valueController = TextEditingController();
  int amount = 1;
  String? cur;

  TextStyle myStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 2);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData = APIHelper.apiHelper.fetchRates(from: "USD", to: "inr", amount: 1);
    valueController.text = '1';
  }

  String dropdownvalue = "USD";
  String dropdownvalue2 = "inr";

  @override
  Widget build(BuildContext context) {
    return (Global.isIOS == false)
        ? Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: Text(
                "Currency Convertor",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green,
              actions: [
                Switch(
                    value: Global.isIOS,
                    onChanged: (val) {
                      setState(() {
                        Global.isIOS = val;
                      });
                    }),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    // key: formKey,
                    child: FutureBuilder(
                      future: getData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          Curency? data = snapshot.data;

                          int amounts = int.parse(valueController.text);

                          return (data != null)
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.max,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            height: 400,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              valueController,
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Enter the value...";
                                                            }
                                                          },
                                                          onSaved: (val) {
                                                            setState(() {
                                                              amount =
                                                                  int.parse(
                                                                      val!);
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "Enter value",
                                                              border:
                                                                  OutlineInputBorder()),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              DropdownButtonFormField(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            iconEnabledColor:
                                                                Colors.white,
                                                            value:
                                                                dropdownvalue,
                                                            icon: Icon(Icons
                                                                .keyboard_arrow_down),
                                                            items: Global
                                                                .allcountry
                                                                .map(
                                                                  (e) =>
                                                                      DropdownMenuItem(
                                                                    value:
                                                                        "${e['from']}",
                                                                    child: Text(
                                                                        "${e['from']}"),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            onChanged: (val) {
                                                              setState(() {
                                                                dropdownvalue =
                                                                    val.toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: Container(
                                                          height: 60,
                                                          width: 160,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "${data.rate * int.parse(valueController.text)}",
                                                            style: myStyle,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                .green[500],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              DropdownButtonFormField(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            iconEnabledColor:
                                                                Colors.white,
                                                            value:
                                                                dropdownvalue2,
                                                            icon: Icon(Icons
                                                                .keyboard_arrow_down),
                                                            items: Global
                                                                .allcountry
                                                                .map(
                                                                  (e) =>
                                                                      DropdownMenuItem(
                                                                    value:
                                                                        e['to'],
                                                                    child: Text(
                                                                        "${e['to']}"),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            onChanged: (val) {
                                                              setState(() {
                                                                dropdownvalue2 =
                                                                    val.toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // int amounts = int.parse(valueController.text);
                                                    setState(() {
                                                      getData = APIHelper
                                                          .apiHelper
                                                          .fetchRates(
                                                              from:
                                                                  dropdownvalue,
                                                              to: dropdownvalue2,
                                                              amount: amounts);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Convert",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 2),
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
                                )
                              : Center(
                                  child: Text("No data found..."),
                                );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            backgroundColor: Colors.grey[300],
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                "Currency Convertor",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: CupertinoSwitch(
                  value: Global.isIOS,
                  onChanged: (val) {
                    setState(() {
                      Global.isIOS = val;
                    });
                  }),
              backgroundColor: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: FutureBuilder(
                      future: getData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          Curency? data = snapshot.data;

                          int amounts = int.parse(valueController.text);

                          return (data != null)
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.max,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            height: 400,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              valueController,
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Enter the value...";
                                                            }
                                                          },
                                                          onSaved: (val) {
                                                            setState(() {
                                                              amount =
                                                                  int.parse(
                                                                      val!);
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "Enter value",
                                                              border:
                                                                  OutlineInputBorder()),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      // Expanded(
                                                      //   flex: 4,
                                                      //   child:
                                                      // ),
                                                      Stack(
                                                        alignment: Alignment.centerRight,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 90,
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Expanded(
                                                              flex: 4,
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  showCupertinoModalPopup(
                                                                    context: context,
                                                                    builder:
                                                                        (context) =>
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              child: Expanded(
                                                                                flex: 3,
                                                                                child:
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(
                                                                                        context);
                                                                                  },
                                                                                  child:
                                                                                  Container(
                                                                                    color: Colors
                                                                                        .black26,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: CupertinoPicker(
                                                                                  backgroundColor: Colors.white,
                                                                                  itemExtent: 30,
                                                                                  children: Global.allcountry.map((e) {
                                                                                    return Text(
                                                                                      e['from'],
                                                                                      style: TextStyle(
                                                                                        color: Colors.black
                                                                                            .withOpacity(0.5),
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    );
                                                                                  }).toList(),
                                                                                  onSelectedItemChanged: (value) {
                                                                                    setState(() {
                                                                                      int i = value;
                                                                                      dropdownvalue = Global.allcountry[i]["Country"]
                                                                                          .toString();
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Text("${data.from}       ",style: TextStyle(color: Colors.white,fontSize: 17),),
                                                          Icon(Icons.arrow_drop_down_outlined,color: Colors.white,size: 25,),
                                                          SizedBox(width: 10,),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: Container(
                                                          height: 60,
                                                          width: 160,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "${data.rate * int.parse(valueController.text)}",
                                                            style: myStyle,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                .green[500],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Stack(
                                                        alignment: Alignment.centerRight,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 90,
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Expanded(
                                                              flex: 4,
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  showCupertinoModalPopup(
                                                                    context: context,
                                                                    builder:
                                                                        (context) =>
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              child: Expanded(
                                                                                flex: 3,
                                                                                child:
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(
                                                                                        context);
                                                                                  },
                                                                                  child:
                                                                                  Container(
                                                                                    color: Colors
                                                                                        .black26,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: CupertinoPicker(
                                                                                  backgroundColor: Colors.white,
                                                                                  itemExtent: 30,
                                                                                  children: Global.allcountry.map((e) {
                                                                                    return Text(
                                                                                      e['to'],
                                                                                      style: TextStyle(
                                                                                        color: Colors.black
                                                                                            .withOpacity(0.5),
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    );
                                                                                  }).toList(),
                                                                                  onSelectedItemChanged: (value) {
                                                                                    setState(() {
                                                                                      int i = value;
                                                                                      dropdownvalue = Global.allcountry[i]["Country"]
                                                                                          .toString();
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Text("${data.to}       ",style: TextStyle(color: Colors.white,fontSize: 17),),
                                                          Icon(Icons.arrow_drop_down_outlined,color: Colors.white,size: 25,),
                                                          SizedBox(width: 10,),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // int amounts = int.parse(valueController.text);
                                                    setState(() {
                                                      getData = APIHelper
                                                          .apiHelper
                                                          .fetchRates(
                                                              from:
                                                                  dropdownvalue,
                                                              to: dropdownvalue2,
                                                              amount: amounts);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Convert",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 2),
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
                                )
                              : Center(
                                  child: Text("No data found..."),
                                );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
