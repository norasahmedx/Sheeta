import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/screens/profile_screens/profile_data.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class PhotosGrid extends StatefulWidget {
  final UserData? user;
  const PhotosGrid({Key? key, required this.user}) : super(key: key);

  @override
  State<PhotosGrid> createState() => _PhotosGridState();
}

class _PhotosGridState extends State<PhotosGrid> {
  late Future<QuerySnapshot> postsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch the posts only if the user object changes
    postsFuture = FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.user!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileData(
                        user: widget.user,
                        initIndex: 0,
                        initialPostIndex: index,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: Image.network(
                    snapshot.data!.docs[index]['post'],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }

        return const LinearProgressIndicator(color: primaryColor);
      },
    );
  }
}
