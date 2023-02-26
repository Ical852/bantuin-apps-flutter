import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTestPage extends StatefulWidget {
  @override
  State<ChatTestPage> createState() => _ChatTestPageState();
}

class _ChatTestPageState extends State<ChatTestPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('icalios_icalandro');
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('icalios_icalandro').orderBy('date').snapshots();
  
  var userId = Platform.isIOS ? 'icalios' : 'icalandro';
  TextEditingController textinput = TextEditingController(text: "");
  Widget getChatBubble(dynamic data) {
    return userId == data['userId'] ? Row(
      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.only(
            bottom: 12
          ),
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12
          ),
          color: Colors.blue,
          child: Text(
            data['message'],
            style: GoogleFonts.poppins().copyWith(
              fontSize: 14,
              color: Colors.white
            ),
          ),
        ),
      ],
    ) : Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6
          ),
          color: Colors.green,
          child: Text(
            data['message'],
            style: GoogleFonts.poppins().copyWith(
              fontSize: 14,
              color: Colors.white
            ),
          ),
        ),
        Spacer()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime Chat Test'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [

            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: usersStream,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("error");
                  }
          
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("loading");
                  }
          
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 24,
                      left: 12,
                      right: 12
                    ),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return getChatBubble(data);
                    }).toList(),
                  );
                }),
              )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 24
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: textinput,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue
                            )
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await users.add({
                          'groupId': 'icalios_icalandro',
                          'userId': userId,
                          'date': DateTime.now(),
                          'message': textinput.text.toString()
                        })
                        .then((value) => print('Berhasil'))
                        .catchError((error) => print('failed' + error));
                        
                        this.textinput.text = '';
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 12
                        ),
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: Container(
                            child: Icon(
                              Icons.send,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}