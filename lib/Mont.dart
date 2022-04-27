import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/DB/KYCMont.dart';
import 'package:untitled/MontPort.dart';
import 'dart:convert';
import 'dart:core';
import 'package:untitled/MontTrading.dart';
import 'package:untitled/profile_page.dart';
import 'package:untitled/settings.dart';
import 'package:untitled/stocks.dart';

import 'calendar.dart';

class Mont extends StatefulWidget {
  const Mont({Key? key}) : super(key: key);

  @override
  _MontState createState() => _MontState();
}
class _MontState extends State<Mont> {
  getMethod() async{
    String theUrl = "https://flutterperform.000webhostapp.com/Montandon.php";
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
          title: const Text('Client Profile'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('On this page you can see details and personal information about a client.'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: const Text('Close'),
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
                    height: 600,
                    child:Card(
                  color: const Color.fromRGBO(52, 99, 141, 800),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
                  child: Padding(
                  padding: const EdgeInsets.all(25.0),
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name: ${snap[index]['name']} ${snap[index]['surname']}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  letterSpacing:2,
                                    color: Colors.white
                                )
                            ),
                            const SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                            Text("Client ID: ${snap[index]['id']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Nationality: ${snap[index]['nationality']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Date of birth: ${snap[index]['birthDate']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Sector: ${snap[index]['sector']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Status: ${snap[index]['status']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Language of reporting: ${snap[index]['lang']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Address: ${snap[index]['address']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Internet Banking: ${snap[index]['internetBanking']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Currency of reporting: ${snap[index]['currency']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing:1,
                                    color: Colors.white60
                                )),
                            Text("Number of portfolios: ${snap[index]['portfolio']}",
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
                const SizedBox(height: 10),
                Material(
                  elevation: 10,
                  borderRadius: const BorderRadius
                      .all(Radius.circular(100.0)),
                  child: Image.asset(
                      'assets/images/user.png',
                      height: 95, width: 95),
                ),
                const SizedBox(height: 495),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    ElevatedButton(
                        onPressed: (){Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const MontPort()));},
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff051b47),
                            fixedSize: const Size(120, 60),
                            side: const BorderSide(width: 1.5, color: Colors.white),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            shadowColor: Colors.white),
                        child: const Text("Portfolios")),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const MontTrading()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff051b47),
                            fixedSize: const Size(120, 60),
                            side: const BorderSide(width: 1.5, color: Colors.white),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            shadowColor: Colors.white),
                        child: const Text("Trading activity",textAlign: TextAlign.center)),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const KYCM()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff051b47),
                            fixedSize: const Size(120, 60),
                            side: const BorderSide(width: 1.5, color: Colors.white),
                            textStyle: const TextStyle(fontSize: 18),
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