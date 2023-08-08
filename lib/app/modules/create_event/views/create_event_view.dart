import 'package:assignment_one/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_event_controller.dart';

// class CreateEventView extends GetView<CreateEventController> {
//   const CreateEventView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CreateEventView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'CreateEventView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descpController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Event',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            buildTextField(controller: titleController, hint: 'Enter Title'),
            SizedBox(height: 20.0),
            buildTextField(
                controller: descpController, hint: 'Enter Description'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    descpController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter title and description'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  final event = MyEvents(
                    eventTitle: titleController.text,
                    eventDescp: descpController.text,
                  );

                  Navigator.pop(context, event);
                }
              },
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      {required TextEditingController controller, String? hint}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint ?? '',
        border: OutlineInputBorder(),
      ),
    );
  }
}
