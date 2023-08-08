import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/card_controller.dart';

class CardView extends GetView<CardController> {
  const CardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CardView'),
        centerTitle: true,
      ),
      body: Center(
        child: card,
      ),
    );
  }

  Widget get card => Container(
        height: 600,
        width: 300,
        color: Colors.grey[300],
        child: Card(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  // Add this
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)), // Add this
                  // color: Colors.red[200], // Add this
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red[200]!,
                      Colors.orange[200]!,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Breakfast',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Breal\nPeanutbuter\nApple',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('525',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Text(' kcal',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
