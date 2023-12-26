import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/models/image.dart';
import 'package:sheeta/static/colors.dart';

class SheetaGallery extends StatefulWidget {
  const SheetaGallery({super.key, this.updateImg});

  final void Function(Uint8List? path, String? name)? updateImg;

  @override
  State<SheetaGallery> createState() => _SheetaGalleryState();
}

class _SheetaGalleryState extends State<SheetaGallery> {
  List<Widget> imageList = [];
  int currPage = 0;
  int? lastPage;

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (currPage == lastPage) return;
    fetchAllImages();
  }

  fetchAllImages() async {
    lastPage = currPage;
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    List<AssetEntity> photos =
        await albums[0].getAssetListPaged(page: currPage, size: 24);

    List<Widget> temp = [];

    for (var photo in photos) {
      temp.add(FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  if (widget.updateImg == null) {
                    Navigator.pop(context,
                        Photo(imgName: photo.title, imgPath: snapshot.data));
                  } else {
                    widget.updateImg!(snapshot.data, photo.title);
                  }
                },
                borderRadius: BorderRadius.circular(5),
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(snapshot.data as Uint8List),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
        future: photo.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
      ));
    }
    setState(() {
      imageList.addAll(temp);
      currPage++;
    });
  }

  @override
  void initState() {
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobBg,
        title: const TextTitle(txt: 'Sheeta'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            handleScrollEvent(scroll);
            return true;
          },
          child: GridView.builder(
            itemCount: imageList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (_, index) {
              return imageList[index];
            },
          ),
        ),
      ),
    );
  }
}
