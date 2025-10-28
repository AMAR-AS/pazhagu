
// lib/screens/create_post_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  File? _selectedFile;
  FileType _fileType = FileType.any;

  Future<void> _pickFile(FileType fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileType = fileType;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement post creation logic
              Navigator.pop(context);
            },
            child: const Text('Post', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: 'Write a caption...',
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            if (_selectedFile != null)
              _buildFilePreview(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _pickFile(FileType.image),
                  icon: const Icon(Icons.image),
                  tooltip: 'Add Image',
                ),
                IconButton(
                  onPressed: () => _pickFile(FileType.video),
                  icon: const Icon(Icons.videocam),
                  tooltip: 'Add Video',
                ),
                IconButton(
                  onPressed: () => _pickFile(FileType.audio),
                  icon: const Icon(Icons.audiotrack),
                  tooltip: 'Add Audio',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

    Widget _buildFilePreview() {
    if (_fileType == FileType.image) {
      return Image.file(_selectedFile!);
    } else if (_fileType == FileType.video) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
            color: Colors.black,
            child: const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 50))),
      );
    } else if (_fileType == FileType.audio) {
      return ListTile(
        leading: const Icon(Icons.audiotrack),
        title: Text(_selectedFile!.path.split('/').last),
      );
    }
    return const SizedBox.shrink();
  }
}
