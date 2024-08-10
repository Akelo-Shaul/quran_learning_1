import 'dart:convert';
import 'package:http/http.dart' as http;

class QuranService {
  final String _baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<dynamic>> getChapters() async {
    final response = await http.get(Uri.parse('$_baseUrl/surah'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load chapters');
    }
  }

  Future<List<dynamic>> getVerses(int chapterNumber) async {
    final response = await http.get(Uri.parse('$_baseUrl/surah/$chapterNumber'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['ayahs'];
    } else {
      throw Exception('Failed to load verses');
    }
  }
}
