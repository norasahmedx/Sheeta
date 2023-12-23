import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController searchController;
  const SearchInput({super.key, required this.searchController});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.searchController,
      decoration: const InputDecoration(labelText: 'Search for a user...'),
    );
  }
}
