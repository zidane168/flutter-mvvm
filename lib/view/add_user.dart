import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:mvvm/data/ApiResponse.dart';
import 'package:mvvm/data/models/update_user.dart';
import 'package:mvvm/view_models/user_view_model.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {

    final _locale = Get.locale;
    final UserViewModel userViewModel  = Get.find();

    String? _email;
    String? _name;

    var logger = new Logger();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "add").toString()),
      ),
      body:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
             Row(
               children: [
                 Text(FlutterI18n.translate(context, "name")),
                 const SizedBox(width: 10),
                 Expanded(
                   child: TextField(
                     onChanged: (value) {
                       _name = value;
                     },
                     decoration: InputDecoration(
                       hintText: "input name",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                       )
                     ),
                   ),
                 )
               ],
             ),
             const SizedBox(height: 10),
             Row(
              children: [
                Text(FlutterI18n.translate(context, "email")),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                        hintText: (FlutterI18n.translate(context, "inputEmail")),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            )
                        )
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {

                      UpdateUser user = UpdateUser(
                        id: 1,
                        email: _email ?? '',
                        name_vi:  _name ?? '',
                        name_en:  _name ?? '',
                      );

                       userViewModel.createUser(user, _locale?.languageCode ?? 'en_US');

                    },
                    child: Text(FlutterI18n.translate(context, "Add Users")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}