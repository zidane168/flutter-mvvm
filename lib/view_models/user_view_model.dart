import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mvvm/data/ApiResponse.dart';
import 'package:mvvm/data/models/update_user.dart';
import 'package:mvvm/data/services/user_service.dart';
import 'package:mvvm/routes/routes.dart';

import '../data/models/user.dart';

class UserViewModel extends GetxController {

  UserViewModel({required this.userService});

  final UserService userService;

  final _users = <User>[].obs;
  List<User> get users => _users.value;

  final logger = Logger();

  Future<void> fetchFullListUsers(String language) async {
    String page = "1";
    String limit = "10";

    logger.d("Language: ${language}");
    final users =  await userService.getFullListUsers(page, limit, language);

    _users.value = users;
  }

  /*
  Future<void> fetchUsers() async {
    final users = await userService.getUsers();
    _users.value = users;
  }
*/
  Future<void> createUser(UpdateUser user, String language) async {
    final rel = await userService.createUser(user, language);
    Get.snackbar("Success", rel.message, snackPosition: SnackPosition.BOTTOM);
    await fetchFullListUsers(language);   // call this for fresh the _users.value = users; and the UI will auto redraw
    Get.toNamed(MyRoutes.getHomeRoute());
  }

  Future<bool> updateUser(UpdateUser user) async {
    final updatedUser = await userService.updateUser(user);
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
       return true;
    }
    return false;
  }

  Future<void> deleteUser(String userId, String language) async {
    await userService.deleteUser(userId, language);
    await fetchFullListUsers(language); // Rel
  }
}