import 'package:assignment_one/app/modules/create_event/views/create_event_view.dart';
import 'package:assignment_one/app/modules/detail_screen/views/detail_screen_view.dart';
import 'package:assignment_one/static/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({Key? key}) : super(key: key);

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  late Map<DateTime, List<MyEvents>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    // print('Getting events for date: $dateTime');
    // print('Events: ${mySelectedEvents[dateTime]}');

    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('New Event'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController, hint: 'Enter Title'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Enter Description'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title & description'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      //Navigator.pop(context);
                      return;
                    } else {
                      setState(() {
                        if (mySelectedEvents[selectedCalendarDate] != null) {
                          mySelectedEvents[selectedCalendarDate]?.add(MyEvents(
                              eventTitle: titleController.text,
                              eventDescp: descpController.text));
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            MyEvents(
                                eventTitle: titleController.text,
                                eventDescp: descpController.text)
                          ];
                        }
                        print('Added event on date: $selectedCalendarDate');
                      });

                      titleController.clear();
                      descpController.clear();

                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  void _navigateToAddEventScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );

    if (result != null && result is MyEvents) {
      final selectedDateEvents = mySelectedEvents[selectedCalendarDate] ?? [];
      setState(() {
        selectedDateEvents.add(result);
        mySelectedEvents[selectedCalendarDate!] = selectedDateEvents;
      });
    }
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Custom Calendar'),
      // ),

      appBar: AppBar(
        title: const Text('Schedule'),
        // add hamburger menu in leading
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        // add notification icon with red circle in action
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColors.ultraRed,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: AppColors.babyPowder,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.eggPlant,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: AppColors.babyPowder,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // grey color floating action button with edit icon
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEventScreen(),
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        backgroundColor: AppColors.babyPowder,
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => _showAddEventDialog(),
      //   label: const Text('Add Event'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(color: AppColors.blackCoffee, width: 2.0),
              ),
              child: TableCalendar(
                calendarFormat: _calendarFormat,

                focusedDay: _focusedCalendarDate,
                // today's date
                firstDay: _initialCalendarDate,
                // earliest possible date
                lastDay: _lastCalendarDate,
                // latest allowed date
                // calendarFormat: CalendarFormat.month,
                // default view when displayed
                // default is Saturday & Sunday but can be set to any day.
                // instead of day number can be mentioned as well.
                weekendDays: const [DateTime.sunday, 6],
                // default is Sunday but can be changed according to locale
                startingDayOfWeek: StartingDayOfWeek.monday,
                // height between the day row and 1st date row, default is 16.0
                daysOfWeekHeight: 40.0,
                // height between the date rows, default is 52.0
                rowHeight: 60.0,

                // this property needs to be added if we want to show events
                // eventLoader: _listOfDayEvents,
                eventLoader: (dateTime) => _listOfDayEvents(dateTime),
                // header visible or not
                headerVisible: true,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() => _calendarFormat = format);
                  }
                },
                // headerStyle: const HeaderStyle(
                headerStyle: const HeaderStyle(
                  titleTextStyle:
                      TextStyle(color: AppColors.babyPowder, fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: AppColors.eggPlant,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle:
                      TextStyle(color: AppColors.ultraRed, fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: AppColors.babyPowder,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: AppColors.babyPowder,
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors.babyPowder,
                    size: 28,
                  ),
                ),
                // Calendar Days Styling
                daysOfWeekStyle: const DaysOfWeekStyle(
                  // Weekend days color (Sat,Sun)
                  weekendStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 158, 158)),
                  // Weekdays color (Mon-Fri)
                  weekdayStyle: TextStyle(color: Colors.grey),
                ),
                // Calendar Dates styling
                calendarStyle: const CalendarStyle(
                  // Weekend dates color (Sat & Sun Column)
                  weekendTextStyle: TextStyle(color: Colors.grey),
                  // highlighted color for today
                  todayDecoration: BoxDecoration(
                    color: AppColors.eggPlant,
                    shape: BoxShape.circle,
                  ),
                  // highlighted color for selected day
                  selectedDecoration: BoxDecoration(
                    color: AppColors.blackCoffee,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                      color: AppColors.ultraRed, shape: BoxShape.circle),
                ),
                selectedDayPredicate: (currentSelectedDate) {
                  // as per the documentation 'selectedDayPredicate' needs to determine
                  // current selected day
                  return (isSameDay(
                      selectedCalendarDate!, currentSelectedDate));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // as per the documentation
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                },
              ),
            ),
            ..._listOfDayEvents(selectedCalendarDate!).map(
              (myEvents) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        eventTitle: myEvents.eventTitle,
                        eventDescp: myEvents.eventDescp,
                        eventDate: selectedCalendarDate!,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: ListTile(
                    // add rounded border to list item
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.eggPlant, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.eggPlant,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.done,
                        color: AppColors.babyPowder,
                      ),
                    ),
                    // in trailing add forward icon
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.eggPlant,
                    ),

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${myEvents.eventTitle}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Text('${myEvents.eventDescp}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}
