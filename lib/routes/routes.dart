import 'package:get/get.dart';
import 'package:mvvm/view/add_user.dart';
import 'package:mvvm/view/user_screen.dart';

class MyRoutes {
  static String home = "/";
  static String addUser = "/adduser";

  static String getHomeRoute() => home;
  static String getAddUserRoute() => addUser;

  static List<GetPage> routes = [
    GetPage(name: getAddUserRoute(), page: () => const AddUser()),

    GetPage(name: getHomeRoute(), page: () =>  UserScreen()),
  ];
}