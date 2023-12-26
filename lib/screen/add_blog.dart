import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as http;

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  String title = '';
  String content = '';
  String author = '';

  openImagePicker() async {
    XFile? selectedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = selectedFile;
    });
  }

  submitForm() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    if (selectedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath("File", selectedImage!.path));
    }

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff005FEE),
        title: const Text("Create New Post"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                if (selectedImage != null)
                  Image.file(File(selectedImage!.path),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fitHeight),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(300, 200),
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      openImagePicker();
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Image",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          Icons.upload_outlined,
                          size: 32,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text("Post Title")),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Title";
                          }
                          return null;
                        },
                        onSaved: (newValue) => title = newValue!,
                      ),
                      TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Description")),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Description";
                            }
                            return null;
                          },
                          onSaved: (newValue) => content = newValue!),
                      TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Author"),
                          ),
                          maxLines: 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Author";
                            }
                            return null;
                          },
                          onSaved: (newValue) => author = newValue!),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color(0xff1A5EE1),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(154, 46)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedImage == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Alert!!'),
                                    content: const Text("Please adding image"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Okay'),
                                      ),
                                    ],
                                  ));
                        }

                        _formKey.currentState!.save();
                        submitForm();
                      }
                    },
                    child: const Text("Upload"))
              ],
            ),
          )),
    );
  }
}
