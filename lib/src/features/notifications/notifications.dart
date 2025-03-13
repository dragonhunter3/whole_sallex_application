import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScheme(context).onPrimary,
        appBar: AppBar(
          backgroundColor: colorScheme(context).onPrimary,
          iconTheme: IconThemeData(color: colorScheme(context).surface),
          title: Text("Notifications"),
          centerTitle: true,
          titleTextStyle: txtTheme(context).displayMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                color: colorScheme(context).onPrimary,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colorScheme(context).primary,
                    child: Icon(Icons.notifications,
                        color: colorScheme(context).onPrimary),
                  ),
                  title: Text(
                    "First Notification",
                    style: txtTheme(context).displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  ),
                  subtitle: Text(
                    "Thanks For creating account",
                    style: txtTheme(context)
                        .headlineSmall
                        ?.copyWith(color: colorScheme(context).surface),
                  ),
                ),
              );
            },
          )),
        ));
  }
}
