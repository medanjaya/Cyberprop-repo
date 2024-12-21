import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class SampleMaps extends StatefulWidget {
  const SampleMaps({super.key});

  @override
  State<SampleMaps> createState() => _SampleMapsState();
}

class _SampleMapsState extends State<SampleMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('help')
      ),
      body: FlutterMap(
        children: [],  
      ),
    );
  }
}