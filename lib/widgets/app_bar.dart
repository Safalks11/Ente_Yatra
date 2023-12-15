import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.grid_view_outlined,
            color: Colors.amber[700],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              _showNotifications(context);
            },
            icon: const Icon(Icons.notifications_none_outlined, size: 27),
          ),
        )
      ],
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300, // Set the height you want for the notification container
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.notifications,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Notifications",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Close",
                              style: TextStyle(color: Colors.red)),
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            leading:
                                CircleAvatar(backgroundColor: Colors.blueGrey),
                            tileColor: Colors.grey,
                            title: Text("Notification 1"),
                            subtitle: Text("Content"),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: 3),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
