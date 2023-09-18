import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageGalleryPage extends StatefulWidget {
  const ImageGalleryPage({super.key});

  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  List<String> imageUrls = []; // 이미지 URL 목록을 저장할 리스트

  @override
  void initState() {
    super.initState();
    _loadImagesFromStorage();
  }

  Future<void> _loadImagesFromStorage() async {
    try {
      // Firebase Storage의 루트 디렉토리 경로를 지정합니다.
      Reference storageReference = FirebaseStorage.instance.ref();

      // 리스트 디렉토리 내의 모든 파일을 나열합니다.
      ListResult result = await storageReference.listAll();

      // 나열된 각 파일에 대해 이미지 URL을 가져와 리스트에 추가합니다.
      for (Reference ref in result.items) {
        String imageUrl = await ref.getDownloadURL();
        setState(() {
          imageUrls.add(imageUrl);
        });
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 열의 개수
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
