import 'package:flutter/material.dart';

class HomeNewCard extends StatelessWidget {
  final String? title;
  final String? url;
  final String? urlToImage;
  final Function(Uri) launchBrowser;

  const HomeNewCard({
    super.key,
    this.title,
    this.url,
    this.urlToImage,
    required this.launchBrowser
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchBrowser(Uri.parse(url.toString()));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xff1f2630),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            urlToImage.toString().isNotEmpty ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                urlToImage.toString(),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/error.png',
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  );
                },
              ),
            ) : ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/error.png',
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
      
            const SizedBox(width: 15),
      
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString(),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}