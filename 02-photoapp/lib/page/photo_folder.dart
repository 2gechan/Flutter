// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photoapp/photo_upload.dart';
import '../main_drawer.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<List<String>> getData(String email) async {
  CollectionReference collectionRef = firestore.collection('photoapp');
  // QuerySnapshot querySnapshot = await collectionRef.get();
  QuerySnapshot querySnapshot =
      await collectionRef.where('id', isEqualTo: email).get();
  List<QueryDocumentSnapshot> documents = querySnapshot.docs;
  List<String> filenameList = [];
  for (QueryDocumentSnapshot document in documents) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String filename = data['f_name'];
    filenameList.add(filename);
    // 데이터를 이용하여 원하는 작업을 수행합니다.
    debugPrint('Document ID: ${document.id}');
    debugPrint('f_name: ${data['f_name']}'); // f_name 필드의 값 출력
  }
  return filenameList;
}

class PhotoFolder extends StatefulWidget {
  const PhotoFolder({super.key});

  @override
  State<PhotoFolder> createState() => _PhotoFolderState();
}

class _PhotoFolderState extends State<PhotoFolder> {
  List<Widget> folder = [];
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<String> filenames = await getData(user?.email ?? "");
    List<Widget> newFolders = filenames.map((filename) {
      return newFolder(filename);
    }).toList();

    setState(() {
      folder.addAll(newFolders);
    });
  }

  // var result = firestore.collection("photoapp").doc("123456789").get();
  Widget alertDialog(BuildContext context) => AlertDialog(
        actions: [
          TextField(
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.name,
            onSubmitted: (value) async {
              var snackBar = SnackBar(
                content: Text("$value가 추가되었음"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop(value);

              await firestore.collection("photoapp").doc().set(
                {
                  "f_name": value,
                  "id": user?.email,
                },
              );
              debugPrint("유저 이메일 : ${user?.email}");

              folder.add(newFolder(value));

              setState(() {});
            },
            decoration: const InputDecoration(
              hintText: "폴더 이름을 입력해주세요",
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: const Text("추억 보관함"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => alertDialog(context),
              );

              debugPrint("아이콘 추가 버튼 클릭");
            },
          ),
        ],
      ),
      body: Wrap(
        children: folder,
      ),
    );
  }
}

class newFolder extends StatefulWidget {
  final String folderName;
  const newFolder(this.folderName, {Key? key}) : super(key: key);

  @override
  State<newFolder> createState() => _newFolderState();
}

class _newFolderState extends State<newFolder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // key: _key,
      padding: const EdgeInsets.all(40.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PhotoApp(folderName: widget.folderName),
          ));
        },
        child: Column(
          children: [
            Container(
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
            Text(widget.folderName)
          ],
        ),
      ),
    );
  }
}
