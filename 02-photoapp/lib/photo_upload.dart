// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'main_drawer.dart';

class PhotoApp extends StatelessWidget {
  final String folderName;
  const PhotoApp({Key? key, required this.folderName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: ImageUpload(folderName: folderName),
    );
  }
}

class ImageUpload extends StatefulWidget {
  final String folderName;
  const ImageUpload({Key? key, required this.folderName}) : super(key: key);

  @override
  State<ImageUpload> createState() => ImageUploadState();
}

final picker = ImagePicker();
FirebaseStorage _storage = FirebaseStorage.instance;
Reference _ref = _storage.ref("/");
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class ImageUploadState extends State<ImageUpload> {
  // 랜덤한 문자열 생성 함수
  String getRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  @override
  void initState() {
    super.initState();
    // 이미지 리스트를 초기화합니다.
    images.clear();
    // 폴더 이름과 일치하는 사진들을 Firebase Firestore에서 불러옵니다.
    _loadImagesFromFirestore();
  }

  Future<void> _loadImagesFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('f_name', isEqualTo: widget.folderName)
          .get();

      // Firestore에서 가져온 이미지 URL을 images 리스트에 추가합니다.
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String imageUrl = doc['image_url'] as String;
        // Firebase Storage에서 이미지를 다운로드하고 로컬 파일로 저장합니다.
        final ref = FirebaseStorage.instance.refFromURL(imageUrl);
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File(
            '${(await getTemporaryDirectory()).path}/${doc['image_name']}');
        await ref.writeToFile(file);

        setState(() {
          images.add(XFile(file.path));
        });
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> uploadImageToStorage(XFile image) async {
    String imageName = getRandomString(10); // 랜덤한 이미지 이름 생성
    Reference storageReference = _ref.child('images/$imageName.jpg');

    File file = File(image.path);
    TaskSnapshot task = await storageReference.putFile(file);
    // await storageReference.putFile(file);

    // 업로드된 이미지의 URL 가져오기
    String imageUrl = await task.ref.getDownloadURL();

    // String imageUrl = await storageReference.getDownloadURL();

    // Firestore에 이미지 정보 저장
    await FirebaseFirestore.instance.collection('images').add({
      'image_url': imageUrl,
      'image_name': imageName,
      'f_name': widget.folderName, // f_name 값을 원하는 값으로 설정
      // 추가 필드도 필요한 경우 여기에 추가
    });

    // 이미지가 업로드되면 리스트에 추가
    setState(() {
      images.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: const Text("추억 보관함"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                //카메라로 촬영하기
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우,
                      // null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images 변수로 저장하도록 합니다
                      if (image != null) {
                        uploadImageToStorage(image);
                      }
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                //갤러리에서 가져오기
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      List<XFile?> multiImage = await picker.pickMultiImage();
                      setState(() {
                        // 갤러리에서 가지고 온 사진들을 images 리스트 변수에 저장
                        images.addAll(multiImage);
                      });
                    },
                    icon: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount:
                    images.length, // 보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //삭제 버튼
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close,
                              color: Colors.white, size: 15),
                          onPressed: () {
                            //버튼을 누르면 해당 이미지가 삭제됨
                            setState(() {
                              images.remove(images[index]);
                            });
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
