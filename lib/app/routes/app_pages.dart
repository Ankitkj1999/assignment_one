import 'package:get/get.dart';

import '../modules/create_event/bindings/create_event_binding.dart';
import '../modules/create_event/views/create_event_view.dart';
import '../modules/detail_screen/bindings/detail_screen_binding.dart';
import '../modules/detail_screen/views/detail_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const CustomTableCalendar(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_EVENT,
      page: () => SecondScreen(),
      binding: CreateEventBinding(),
    ),
    // GetPage(
    //   name: _Paths.DETAIL_SCREEN,
    //   page: () => DetailScreen(eventDate: null, eventDescp: '', eventTitle: '',),
    //   binding: DetailScreenBinding(),
    // ),
  ];
}
