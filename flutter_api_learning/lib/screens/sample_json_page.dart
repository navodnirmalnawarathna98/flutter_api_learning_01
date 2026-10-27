import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/sample_json_service.dart';

class SampleJsonPage extends StatefulWidget {
  const SampleJsonPage({super.key});

  @override
  State<SampleJsonPage> createState() => _SampleJsonPageState();
}

class _SampleJsonPageState extends State<SampleJsonPage> {
  final SampleJsonService _service = SampleJsonService();

  late Future<Student> _studentFuture;

  @override
  void initState() {
    super.initState();
    _studentFuture = _service.loadStudent();
  }

  void _reloadStudent() {
    setState(() {
      _studentFuture = _service.loadStudent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample JSON'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _reloadStudent,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload sample data',
          ),
        ],
      ),
      body: FutureBuilder<Student>(
        future: _studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Unable to read sample JSON.'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _reloadStudent,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          final student = snapshot.data;

          if (student == null || student.name.isEmpty) {
            return const Center(
              child: Text('No student data available.'),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              const Text(
                'Student Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _detail('Student ID', '${student.id}'),
                      _detail('Name', student.name),
                      _detail('Course', student.course),
                      _detail('Email', student.email),
                      _detail(
                        'Status',
                        student.active ? 'Active' : 'Inactive',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Source: Local JSON asset',
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _detail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

