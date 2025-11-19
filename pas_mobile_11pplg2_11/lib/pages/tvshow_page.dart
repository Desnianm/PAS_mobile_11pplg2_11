import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/tvshow_controller.dart';
import '../controller/bookmark_controller.dart';
import '../widget/custom_tvshow.dart';

class TvshowPage extends StatelessWidget {
  const TvshowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvC = Get.put(TvShowController());
    final bmC = Get.put(BookmarkController());

    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Get.toNamed('/favorites'),
          ),
        ],
      ),

      body: Obx(() {
        if (tvC.loading.value) return Center(child: CircularProgressIndicator());
        if (tvC.error.value != null) {
          return Center(child: Text('Error: ${tvC.error.value}'));
        }

        return RefreshIndicator(
          onRefresh: tvC.refresh,
          child: ListView.builder(
            itemCount: tvC.shows.length,
            itemBuilder: (context, index) {
              final show = tvC.shows[index];
              final imageUrl = show.image.medium;
              final summary = (show.summary ?? '');
                

              return Stack(
                children: [
                  CustomTvShowCard(
                    title: show.name,
                    posterUrl: imageUrl,
                    description: summary,
                    onTap: () {
                    
                    },
                  ),

                  
                  Positioned(
                    right: 28,
                    top: 18,
                    child: Obx(() {
                      final fav = bmC.isFavorited(show.id);
                      return InkWell(
                        onTap: () async {
                          await bmC.toggleFavorite(show);
                          Get.snackbar(
                            fav ? 'Removed' : 'Saved',
                            show.name,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            fav ? Icons.favorite : Icons.favorite_border,
                            color: fav ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
