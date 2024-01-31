import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoViewScreen extends StatefulWidget {
  final String imgUrl;

  const PhotoViewScreen({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Imageview"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: InteractiveViewer(
          maxScale: 4,
          minScale: 1,
          child: CachedNetworkImage(
            imageUrl: widget.imgUrl,
            fit: BoxFit.contain,
            height: mediaQuery.height,
            width: mediaQuery.width,
            placeholder: (context, url) => const SizedBox(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
