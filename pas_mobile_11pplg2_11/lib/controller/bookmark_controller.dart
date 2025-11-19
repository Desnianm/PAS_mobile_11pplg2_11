// lib/controllers/bookmark_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tv_model.dart';

class BookmarkController extends GetxController {
  final _key = 'favorites';
  var favorites = <Tvmodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final List<dynamic> decoded = json.decode(jsonStr);
        favorites.assignAll(decoded.map((e) => Tvmodel.fromJson(e)).toList());
      } catch (e) {
      
        await prefs.remove(_key);
        favorites.clear();
      }
    } else {
      favorites.clear();
    }
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode(favorites.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonStr);
  }

  bool isFavorited(int id) => favorites.any((f) => f.id == id);

  Future<void> addFavorite(Tvmodel show) async {
    if (!isFavorited(show.id)) {
      favorites.add(show);
      await _savePrefs();
    }
  }

  Future<void> removeFavorite(int id) async {
    favorites.removeWhere((f) => f.id == id);
    await _savePrefs();
  }

  Future<void> toggleFavorite(Tvmodel show) async {
    if (isFavorited(show.id)) {
      await removeFavorite(show.id);
    } else {
      await addFavorite(show);
    }
  }
}
