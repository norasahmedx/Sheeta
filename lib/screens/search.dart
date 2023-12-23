import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/searched_user_card.dart';
import 'package:sheeta/components/designs/inputs/search.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/static/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //* Refresh the screen
    searchController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchInput(searchController: searchController),
        ),
        body: searchController.text.isNotEmpty
            ? FutureBuilder(
                future: Auth()
                    .searchBy(val: searchController.text, prop: 'username'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return SearchedUserCard(users: snapshot.data!.docs);
                  }

                  return const LinearProgressIndicator(color: primaryColor);
                },
              )
            : const SizedBox());
  }
}
