import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/tvshow_controller.dart';
import '../controller/bookmark_controller.dart';
import '../widget/custom_tvshow.dart';

class TvshowPage extends StatelessWidget {
  const TvshowPage({super.key});
  String stripHtml(String text) {
    bool tag = false;
    final buffer = StringBuffer();

    for (var ch in text.runes) {
      final char = String.fromCharCode(ch);
      if (char == '<') {
        tag = true;
        continue;
      } else if (char == '>') {
        tag = false;
        continue;
      }
      if (!tag) buffer.write(char);
    }

    return buffer.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    final tvC = Get.find<TvShowController>();
    final favC = Get.find<BookmarkController>();

    return Scaffold(
      backgroundColor: const Color(0xfff7f0ff),

      appBar: AppBar(
        title: const Text(
          "TV Shows",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff7b5cff), Color(0xffb193ff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Obx(() {
        final _ = favC.favorites;

        if (tvC.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tvC.shows.isEmpty) {
          return Center(
            child: Text(
              "Tidak ada data",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: tvC.refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),

            children: [
              const SizedBox(height: 5),
              Text(
                "Rekomendasi Untuk Anda",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple.shade300,
                ),
              ),

              const SizedBox(height: 15),

              ...tvC.shows.map((item) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.only(bottom: 18),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: CustomTvShowCard(
                    title: item.name,
                    poster: item.image.medium ?? item.image.original,
                    summary: stripHtml(item.summary),
                    rating: item.rating.average ?? 0.0,

                    trailing: IconButton(
                      icon: Icon(
                        favC.isFavorited(item.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favC.isFavorited(item.id)
                            ? Colors.pinkAccent
                            : Colors.grey.shade600,
                      ),
                      onPressed: () async {
                        bool isFav = favC.isFavorited(item.id);
                        await favC.toggleFavorite(item);

                        Get.snackbar(
                          "Favorit",
                          isFav
                              ? "Dihapus dari favorit"
                              : "Ditambahkan ke favorit",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }),
    );
  }
}
