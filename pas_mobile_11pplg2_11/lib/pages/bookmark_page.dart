import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bookmark_controller.dart';
import '../widget/custom_tvshow.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bmC = Get.find<BookmarkController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),

      body: Obx(() {
        if (bmC.favorites.isEmpty) {
          return Center(child: Text('No favorites yet'));
        }

        return ListView.builder(
          itemCount: bmC.favorites.length,
          itemBuilder: (context, i) {
            final show = bmC.favorites[i];
            final imageUrl = show.image.medium;
            final summary = (show.summary ?? '');
              

            return Stack(
              children: [
                
                CustomTvShowCard(
                  title: show.name,
                  posterUrl: imageUrl,
                  description: summary,
                 
                ),

                
                Positioned(
                  right: 26,
                  top: 16,
                  child: InkWell(
                    onTap: () async {
                      await bmC.removeFavorite(show.id);
                      Get.snackbar(
                        'Removed',
                        show.name,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.delete, color: Colors.red, size: 20),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
