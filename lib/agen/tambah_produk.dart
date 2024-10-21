import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart'; // Import for video playback

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  String dropdownValue = 'Rumah/ruko'; // Initial selection for dropdown menu
  XFile? _image; // Declaration for image file
  VideoPlayerController? _videoController; // Declaration for video controller
  int _selectedIndex = 0; // Add selected index for BottomNavigationBar

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
      _videoController?.dispose();
      _videoController = null;
    });
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      setState(() {
        _image = null;
        _videoController = VideoPlayerController.file(File(pickedVideo.path))
          ..initialize().then((_) {
            setState(() {}); // Update UI after initialization
            _videoController!.play();
          });
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Properti Baru',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama Properti',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              // Image picker section with SizedBox
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: _image != null ? Colors.transparent : Colors.grey[200],
                  ),
                  child: _image != null
                      ? SizedBox(
                          width: 150, // Set your desired width
                          height: 150, // Set your desired height
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 16),
              // Video picker section with SizedBox
              GestureDetector(
                onTap: _pickVideo,
                child: Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: _videoController != null
                        ? Colors.transparent
                        : Colors.grey[200],
                  ),
                  child: _videoController != null &&
                          _videoController!.value.isInitialized
                      ? SizedBox(
                          width: 150, // Set your desired width
                          height: 150, // Set your desired height
                          child: AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                        )
                      : const Icon(Icons.videocam),
                ),
              ),
              const SizedBox(height: 16),
              // Dropdown menu for property type
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Color.fromARGB(255, 167, 86, 86)),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 167, 86, 86),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Rumah/ruko',
                  'Apartemen/kondominium',
                  'Villa',
                  'Tanah'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Alamat Field
              const Text(
                'Alamat',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              // Tambah di antara 'Alamat' dan 'Deskripsi'
const Text(
  'Ukuran Properti',
  style: TextStyle(
    color: Color.fromARGB(255, 167, 86, 86),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
const SizedBox(height: 8),
Row(
  children: [
    // TextField untuk panjang
    Expanded(
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Panjang (meter)',
          filled: true,
          fillColor: Color.fromARGB(255, 233, 239, 214),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
      ),
    ),
    const SizedBox(width: 16), // Memberi jarak di antara kedua TextField
    // TextField untuk lebar
    Expanded(
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Lebar (meter)',
          filled: true,
          fillColor: Color.fromARGB(255, 233, 239, 214),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
      ),
    ),
  ],
),
const SizedBox(height: 16),
              // Deskripsi Field
              const Text(
                'Deskripsi',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),

              // Harga Field
const Text(
  'Harga',
  style: TextStyle(
    color: Color.fromARGB(255, 167, 86, 86),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
const SizedBox(height: 8),
TextField(
  decoration: const InputDecoration(
    prefixText: 'Rp ',
    filled: true,
    fillColor: Color.fromARGB(255, 233, 239, 214),
    border: InputBorder.none,
  ),
  keyboardType: TextInputType.number, // To ensure numeric input
),
const SizedBox(height: 16),

// Submit Button
Center(
  child: ElevatedButton(
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/menu'); // Navigates back to 'menu.dart'
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    child: const Text(
      'Submit',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  ),
),
            
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Kontak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Properti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor:
            const Color.fromARGB(255, 255, 223, 183), // Warna latar belakang
      ),
    );
  }
}
