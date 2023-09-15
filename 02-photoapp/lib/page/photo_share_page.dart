import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photoapp/main_drawer.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

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

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: const Text("추억 보관함"),
      ),
      body: const Center(child: Text("공유이미지 페이지")),
    );
  }
}
