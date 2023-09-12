import 'package:flutter/material.dart';
import 'package:photoapp/photo_upload.dart';

import '../main_drawer.dart';

class PhotoFolder extends StatefulWidget {
  const PhotoFolder({super.key});

  @override
  State<PhotoFolder> createState() => _PhotoFolderState();
}

class _PhotoFolderState extends State<PhotoFolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: const Text("추억 보관함"),
      ),
      body: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const PhotoApp(),
                  ),
                );
              },
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      // color: Colors.grey[500],
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.folder,
                  size: 50,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const PhotoApp(),
                  ),
                );
                debugPrint("폴더 클릭");
              },
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      // color: Colors.grey[500],
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.folder,
                  size: 50,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: const [
                  BoxShadow(
                    // color: Colors.grey[500],
                    offset: Offset(3.0, 3.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.folder,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
