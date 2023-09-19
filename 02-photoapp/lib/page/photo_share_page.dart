import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoapp/main_drawer.dart';
import 'package:path_provider/path_provider.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

final picker = ImagePicker();
FirebaseStorage _storage = FirebaseStorage.instance;
Reference _ref = _storage.ref("/");
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class _SharePageState extends State<SharePage> {
  Future<void> _loadImagesFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('images').get();

      // Firestore에서 가져온 이미지 URL을 images 리스트에 추가합니다.
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String imageUrl = doc['image_url'] as String;

        // Firestore에 저장된 이미지 URL이 올바른 형식이 아닐 경우 처리
        if (imageUrl.startsWith('gs://') || imageUrl.startsWith('http')) {
          // Firebase Storage에서 이미지를 다운로드하고 로컬 파일로 저장합니다.
          final ref = FirebaseStorage.instance.refFromURL(imageUrl);
          final Directory tempDir = await getTemporaryDirectory();
          final File file = File(
              '${(await getTemporaryDirectory()).path}/${doc['image_name']}');
          await ref.writeToFile(file);

          setState(() {
            images.add(XFile(file.path));
          });
        } else {
          print('Invalid image URL: $imageUrl');
        }
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    images.clear();
    _loadImagesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: const Text("추억 공유함"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: images.length, // 보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 1 개의 행에 보여줄 사진 개수
            childAspectRatio: 1 / 1, // 사진의 가로 세로의 비율
            mainAxisSpacing: 10, // 수평 Padding
            crossAxisSpacing: 10, // 수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover, //사진을 크기를 상자 크기에 맞게 조절
                      image: FileImage(
                        File(images[index]!
                                .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                            ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   //삭제 버튼
                //   child: IconButton(
                //     padding: EdgeInsets.zero,
                //     constraints: const BoxConstraints(),
                //     icon:
                //         const Icon(Icons.close, color: Colors.white, size: 15),
                //     onPressed: () {
                //       //버튼을 누르면 해당 이미지가 삭제됨
                //       setState(() {
                //         images.remove(images[index]);
                //       });
                //     },
                //   ),
                // )
              ],
            );
          },
        ),
      ),
    );
  }
}
