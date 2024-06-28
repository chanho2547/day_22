import 'dart:io';

import 'package:day_22/features/write/views/video_screen.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unsplash_client/unsplash_client.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final Faker _faker = Faker();
  final client = UnsplashClient(
    settings: const ClientSettings(
        credentials: AppCredentials(
      accessKey: 'oW5CFs6CDHAJr79an_ky432z3XXTJS2GBnaxxeTj0BY',
      secretKey: 'IxCi0xW2kVzqrRGViVZxyTE_uUWiTM1YUsliZMhrGdg',
    )),
  );
  List<Photo> _thumb = [];
  final List<XFile> _photos = [];
  final ImagePicker _picker = ImagePicker();
  bool isFileUploaded = false;
  @override
  void initState() {
    super.initState();
    makeThumb();
  }

  void makeThumb() async {
    final thumb = await client.photos.random(count: 1).goAndGet();

    setState(() {
      _thumb = thumb;
    });
  }

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
  }

  void _onCameraTap() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    _addCamera(image);
  }

  void _onImageTap() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    _addImage(image);
  }

  void _addImage(XFile image) {
    _photos.add(image);
    isFileUploaded = true;
    setState(() {});
  }

  void _addCamera(XFile image) {
    _photos.add(image);
    isFileUploaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Center(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        title: const Text(
          "New thread",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onBodyTap,
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: _thumb.isNotEmpty
                            ? NetworkImage(_thumb.first.urls.thumb.toString())
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 2,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      const FaIcon(FontAwesomeIcons.users),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _faker.person.name(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            maxLines: null,
                            expands: true,
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                              hintText: "Start a thread...",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: isFileUploaded
                              ? Center(
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.file(
                                      File(_photos.first.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: _onCameraTap,
                        icon: const FaIcon(FontAwesomeIcons.video),
                      ),
                      IconButton(
                        onPressed: _onImageTap,
                        icon: const FaIcon(FontAwesomeIcons.solidImage),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Anyone can reply",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "Post",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
