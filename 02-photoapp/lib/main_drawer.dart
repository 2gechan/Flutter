import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photoapp/main.dart';
import 'package:photoapp/page/photo_folder.dart';
import 'package:photoapp/page/photo_share_page.dart';

Widget mainDrawer(BuildContext context, {User? authUser}) => Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(""),
            accountEmail: Text(authUser?.email ?? ""),
          ),
          ListTile(
            title: const Text(
              "HOME",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StartPage(),
              ));
            },
          ),
          // const Divider(
          //   height: 0.2,
          //   color: Colors.black,
          // ),
          ListTile(
            title: const Text(
              "내 추억 보관함",
              style: TextStyle(
                color: Color.fromARGB(255, 220, 139, 205),
              ),
            ),
            leading: const Icon(
              Icons.photo,
              color: Color.fromARGB(255, 220, 139, 205),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PhotoFolder()
                      // const PhotoApp(),
                      ));
            },
          ),
          // const Divider(
          //   height: 0.2,
          //   color: Colors.black,
          // ),
          ListTile(
            title: const Text(
              "추억 공유함",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            leading: const Icon(
              Icons.photo,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SharePage()
                      // const PhotoApp(),
                      ));
            },
          ),
        ],
      ),
    );
