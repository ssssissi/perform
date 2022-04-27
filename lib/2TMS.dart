import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

import 'package:untitled/1TMStager.dart';
import 'package:untitled/profile_page.dart';
import 'package:untitled/settings.dart';
import 'package:untitled/stocks.dart';

import '3TMS.dart';
import 'KYCStager.dart';
import 'calendar.dart';


class STMS extends StatefulWidget {
  const STMS({Key? key}) : super(key: key);

  @override
  _STMSState createState() => _STMSState();
}
class _STMSState extends State<STMS> {
  getMethod() async{
    String theUrl = "https://flutterperform.000webhostapp.com/2Stager.php";
    var res = await http.get(Uri.parse(theUrl), headers: {"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    print(responseBody);
    return responseBody;
  }
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          scrollable: true,
          backgroundColor: const Color(0xff051b47),
          title: const Text('2nd Month Activity', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('Visualisation of the second month trading activity.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                const Text('Portfolio 1',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18)),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/TM2_1S1.png',
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                const Text('Transaction 2.1',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/TM2_2S1.png',
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                const Text('Transaction 2.2',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      bottomNavigationBar:
      BottomAppBar(
        color:const Color(0xff051b47),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  const Calender()));
            }, icon: const Icon(Icons.calendar_today,color: Colors.white,
                size:32)),
            const SizedBox(width: 80),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  const Stocks()));
            }, icon: const Icon(Icons.analytics, color: Colors.white, size: 32)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.account_circle,
          size: 50,
          color: Color(0xff051b47)),
          backgroundColor: Colors.white,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const MyProfile()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text("PerfoRM", textAlign: TextAlign.center),
        backgroundColor: const Color(0xff051b47),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.info),
              onPressed: _showcontent),
          IconButton(icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  const Settings()));
              })
        ],
      ),
      body: Stack(
        children:[
          FutureBuilder(
            future: getMethod(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              List snap=snapshot.data;
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.hasError){
                return const Center(
                  child: Text("Error"),
                );
              }
              return ListView.builder(
                itemCount:snap.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                dragStartBehavior: DragStartBehavior.down,
                itemBuilder: (context, index)
                {
                  return SizedBox(
                    height: 1100,
                    child: Card(
                      color: const Color.fromRGBO(52, 99, 141, 800),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 25),
                            const Text("Second Trading Month Activity",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  letterSpacing:2,
                                  color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Portfolio ID: ${snap[index]['portfolioID']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Security ID 2.1: ${snap[index]['securityID2_1']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Security Amount 2.1: ${snap[index]['securityAmount2_1']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Transaction Date: ${snap[index]['dateOfTran2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Type of Transaction 2.1: ${snap[index]['transType2_1']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Company: ${snap[index]['company']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Short Description: ${snap[index]['compDescr']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Currency: ${snap[index]['currency']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 1: ${snap[index]['price1']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 1 Date: ${snap[index]['price1Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 2: ${snap[index]['price2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 2 Date: ${snap[index]['price2Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 3: ${snap[index]['price3']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 3 Date: ${snap[index]['price3Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 4: ${snap[index]['price4']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 4 Date: ${snap[index]['price4Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 5: ${snap[index]['price5']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 5 Date: ${snap[index]['price5Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Security ID 2.2: ${snap[index]['securityID2_2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Type of Transaction 2.1: ${snap[index]['transType2_1']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Company 2: ${snap[index]['company2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Short Description 2: ${snap[index]['companyDescr2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Currency: ${snap[index]['currency2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 1: ${snap[index]['price1_2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 1 Date: ${snap[index]['price1_2Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 2: ${snap[index]['price2_2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 2 Date: ${snap[index]['price2_2Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 3: ${snap[index]['price3_2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 3 Date: ${snap[index]['price3_2Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 4: ${snap[index]['price4_2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 4 Date: ${snap[index]['price4_2Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 5: ${snap[index]['price5_2']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                                Text("Price No 5 Date: ${snap[index]['price5_2Date']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        letterSpacing:1,
                                        color: Colors.white60
                                    )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Column(
              children: [
                const SizedBox(height: 5),
                Material(
                  elevation: 10,
                  borderRadius: const BorderRadius
                      .all(Radius.circular(50.0)),
                  child: Image.asset(
                      'assets/images/user.png',
                      height: 95, width: 95),
                ),
                const SizedBox(height: 500),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => const FTMS()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff051b47),
                            fixedSize: const Size(120, 60),
                            side: const BorderSide(width: 1.5, color: Colors.white),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            shadowColor: Colors.white),
                        child: const Text("First Month activity",textAlign: TextAlign.center)),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => const TTMS()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff051b47),
                            fixedSize: const Size(120, 60),
                            side: const BorderSide(width: 1.5, color: Colors.white),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            shadowColor: Colors.white),
                        child: const Text("Third Month activity",textAlign: TextAlign.center)),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => const KYCS()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff051b47),
                            fixedSize: const Size(120, 60),
                            side: const BorderSide(width: 1.5, color: Colors.white),
                            textStyle: const TextStyle(fontSize: 16, ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            shadowColor: Colors.white),
                        child: const Text("KYC Check", textAlign: TextAlign.center)),
                  ],
                ),
              ]
          ),
        ],
      ),
    );
  }
}