import 'dart:convert';
import 'package:http/http.dart' as http;

class WallpaperProvider {
  static Future<List<String>> searchWallpapers(String searchTerm, int perPage) async {
    const apiKey = '36954949-b793f308fc91ba642f2c2a586';
    final url =
        'https://pixabay.com/api/?key=$apiKey&q=$searchTerm&image_type=photo';

    final response = await http.get(Uri.parse(url));
   if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> wallpapers = [];
      for (var image in data['hits']) {
        wallpapers.add(image['largeImageURL']);
      }
      return wallpapers;
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
  }
