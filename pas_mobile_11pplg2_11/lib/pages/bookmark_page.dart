import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bookmark_controller.dart';
import '../models/tv_model.dart';
import '../widget/custom_tvshow.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  String stripHtml(String? text) {
    if (text == null) return "";
    bool tag = false;
    final buffer = StringBuffer();

    for (var rune in text.runes) {
      final char = String.fromCharCode(rune);
      if (char == '<') {
        tag = true;
        continue;
      }
      if (char == '>') {
        tag = false;
        continue;
      }
      if (!tag) buffer.write(char);
    }

    return buffer.toString().trim();
  }
  @override
  Widget build(BuildContext context) {
    final BookmarkController favC = Get.find<BookmarkController>();

    return Scaffold(
      backgroundColor: const Color(0xfff7f8fc),
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
      ),
      body: Obx(() {
        if (favC.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border,
                    size: 80, color: Colors.blue.shade300),
                const SizedBox(height: 10),
                Text(
                  "Belum ada favorit",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: favC.favorites.length,
          itemBuilder: (context, index) {
            final Tvmodel item = favC.favorites[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Dismissible(
                key: ValueKey(item.id),
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.startToEnd,

                onDismissed: (_) async {
                  await favC.removeFavorite(item.id);
                  Get.snackbar(
                    "Favorit",
                    "Dihapus dari favorit",
                    backgroundColor: Colors.red.shade100,
                  );
                },

                child: CustomTvShowCard(
                  title: item.name ?? "-",
                  poster: item.image?.medium ??
                      "https://via.placeholder.com/150x200?text=No+Image",
                  summary: stripHtml(item.summary),
                  rating: item.rating?.average?.toDouble(),

                  trailing: IconButton(
                    onPressed: () async {
                      await favC.removeFavorite(item.id);
                      Get.snackbar("Favorit", "Dihapus dari favorit");
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.red.shade400,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
