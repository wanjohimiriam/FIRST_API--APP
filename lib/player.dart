// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlayerApp extends StatefulWidget {
  const PlayerApp({super.key});

  @override
  State<PlayerApp> createState() => _PlayerAppState();
}

class _PlayerAppState extends State<PlayerApp> {
  List<dynamic> data = [];

  Future<void> fecthData(String url) async {
    // final url = 'https://www.balldontlie.io/api/v1/players';
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "Application/json"});

    if (res.statusCode == 200) {
      var responseData = json.decode(res.body);
      setState(() {
        data = responseData['data'];
        //print(data);
      });
    } else {
      Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.deepPurple.shade200,
        ),
      );
    }
  }

  @override
  void initState() {
    fecthData('https://www.balldontlie.io/api/v1/players');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurple.shade400,
        title: Center(child: Text("Players")),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.grey.shade200,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: Colors.white24
                        )
                      ]
                    ),
                    
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    // elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.deepPurple.shade400,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "id: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text('${data[index]['id']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black,
                                    )),
                                  ],
                                ),
                                //   Text("First Name: ${data[index]['first_name']}"),
                                //   Text("Last Name: ${data[index]['last_name']}"),
                                //  Text("City: ${data[index]["team"]['full_name']}")
                              ],
                            ),
                          ),
                          // Text("Division${data[index]['team']['division']}")
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Divider(
                    height: 1,
                    color: Colors.black12,
                  ),
                )
              ],
            );
            // return ListTile(
            //   title: Text("${data[index]['last_name']}")
            // );
          })),
    );
  }
}
