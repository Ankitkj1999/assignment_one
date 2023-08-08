import 'package:assignment_one/static/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_screen_controller.dart';

// class DetailScreenView extends GetView<DetailScreenController> {
//   const DetailScreenView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DetailScreenView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'DetailScreenView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class DetailScreen extends StatelessWidget {
  final String eventTitle;
  final String eventDescp;
  final DateTime eventDate;

  DetailScreen({
    required this.eventTitle,
    required this.eventDescp,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 5, right: 12, left: 12),
            child: Container(
              // padding: EdgeInsets.all(12),
              height: 200.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.eggPlant,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/event.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image.asset('assets/event.jpg'),
            ),
          ),
          // Replace with your image asset
          // SizedBox(height: 20.0),
          Container(
            // rounder corners with light grey color decoration
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 53, 53, 53),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    // Rich text with Event with pupule color and $eventTitle with black color
                    RichText(
                        text: TextSpan(
                      text: 'Event: ',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.eggPlant),
                      children: <TextSpan>[
                        TextSpan(
                            text: '$eventTitle',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.eggPlant,
                        ),
                        Text('  Johansi Berline'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.eggPlant,
                        ),
                        Text('  ${DateFormat('yyyy-MM-dd').format(eventDate)}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  // width: 300,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 320,
                        child: Text(
                          'Description: $eventDescp',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                // two outline button in a row one saying 'Cancel' and other 'Join'
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      // purple color and curculat border
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),

                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    OutlinedButton(
                      // purple color and curculat border
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: BorderSide(
                          color: AppColors.eggPlant,
                          width: 2.0,
                        ),
                      ),

                      onPressed: () {},
                      child: Text(
                        'Join',
                        style:
                            TextStyle(color: AppColors.eggPlant, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
