import 'package:flutter/material.dart';

class CustomTvShowCard extends StatelessWidget {
  final String title;
  final String poster;
  final String summary;
  final double? rating;
  final Widget? trailing;

  const CustomTvShowCard({
    super.key,
    required this.title,
    required this.poster,
    required this.summary,
    this.rating,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              poster,
              width: 95,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    SizedBox(width: 4),
                    Text(
                      rating?.toString() ?? "-",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                Text(
                  summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
