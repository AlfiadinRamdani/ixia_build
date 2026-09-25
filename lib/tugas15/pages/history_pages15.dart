import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dio_client.dart';

class HistoryPages15 extends StatefulWidget {
  const HistoryPages15({super.key});

  @override
  State<HistoryPages15> createState() => _HistoryPages15State();
}

class _HistoryPages15State extends State<HistoryPages15> {
  final Dio _dio = createDioClient();
  List<dynamic> _historyList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      final response = await _dio.get('history-absen');
      if (response.statusCode == 200) {
        setState(() {
          _historyList = response.data is List ? response.data : response.data['data'] ?? [];
        });
      }
    } catch (e) {
      debugPrint('Error fetch history: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteAbsen(dynamic id) async {
    try {
      final response = await _dio.delete('delete-absen', queryParameters: {'id': id});
      if (response.statusCode == 200) {
        _fetchHistory();
      }
    } catch (e) {
      debugPrint('Delete failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Absensi')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _historyList.length,
              itemBuilder: (context, index) {
                final item = _historyList[index];
                return ListTile(
                  title: Text(item['tanggal'] ?? item['created_at'] ?? '-'),
                  subtitle: Text('Masuk: ${item['jam_masuk'] ?? '-'} | Pulang: ${item['jam_keluar'] ?? '-'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteAbsen(item['id']),
                  ),
                );
              },
            ),
    );
  }
}