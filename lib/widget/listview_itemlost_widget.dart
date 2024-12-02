import 'package:flutter/material.dart';
import 'package:wdalivraia/services/itemlost_services.dart';
import 'dart:convert';

import '../models/notes_itemlost.dart';

class CustomListView2 extends StatefulWidget {

  @override
  State<CustomListView2> createState() => _CustomListView2State();
}

class _CustomListView2State extends State<CustomListView2> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.all(2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/item.jpeg',
                  width: MediaQuery.of(context).size.width * 0.30,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left:4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Garrafa vermelha", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Icon(Icons.favorite_border, size: 25, color: Colors.grey[400],)
                        ],
                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Garrafa vermelha passo sem nome", style: TextStyle(fontSize: 14, color: Colors.grey),),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Colors.grey, // Cor da borda
                                width: 2, // Espessura da borda
                              ),
                            ),
                            foregroundColor: Colors.black,
                            elevation: 0,
                          ),
                          onPressed: (){},
                          child: Text(
                            "Mais informaçoes",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black
                            ),
                          ),
                        ),
                    ],),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}
