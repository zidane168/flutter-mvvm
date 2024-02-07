import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mvvm/routes/routes.dart';
import 'package:mvvm/view_models/user_view_model.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final UserViewModel userViewModel  = Get.find();

  @override
  Widget build(BuildContext context) {

    var logger = Logger();
    final _locale = Get.locale;

    void toggleLanguage() {

      logger.d(_locale?.languageCode);
      if (_locale?.languageCode == 'en') {
        Get.updateLocale(Locale('vi' )); // Switch to Vietnamese locale
      } else {
        Get.updateLocale(Locale('en' )); // Switch to English locale
      }
    }

    // TODO: implement build
    return   Scaffold(
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, "greeting" ).toString()),
        ),
      
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: toggleLanguage,
                        child: Text(FlutterI18n.translate(context, "switchLanguage").toString()),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        //onPressed: () => userViewModel.fetchUsers(),
                        onPressed: () => {
                          userViewModel.fetchFullListUsers(_locale?.languageCode ?? 'en_US'),
                        },
                        child: Text(FlutterI18n.translate(context, "showUser").toString()),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => {
                        Get.toNamed(MyRoutes.getAddUserRoute())
                      },
                      child: Text(FlutterI18n.translate(context, "add").toString()),
                    ),
                  ],
                ),
              ),

              Expanded(
                child:
                  Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount:  userViewModel.users.length,
                          itemBuilder: (BuildContext context, int index) {

                            final user = userViewModel.users[index];

                            return ListTile(
                              // title: Text(user.name),
                              title:  user?.userLanguages != null && user.userLanguages!.isNotEmpty ? Text(user.userLanguages![0].name ?? '') : Text(''),
                              subtitle: Text(user.email),
                              trailing:  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: ()  { }
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => {
                                        userViewModel.deleteUser(user.id.toString(), _locale?.languageCode ?? "en_US"),
                                       }
                                    ),
                                  ],
                                ),
                            );
                          },
                      )
                  ),

              )
            ],
          ),
        ),
    );
  }

}