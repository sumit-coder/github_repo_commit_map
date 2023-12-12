import 'package:flutter/material.dart';

class SearchBarCard extends StatelessWidget {
  const SearchBarCard({super.key, required this.onTapSearch, required this.searchInputController});

  final VoidCallback onTapSearch;
  final TextEditingController searchInputController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 664,
      height: 64,
      margin: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(-1, -1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 600,
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: TextField(
                controller: searchInputController,
                style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1),
                decoration: const InputDecoration(
                  border: InputBorder.none,

                  // focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              color: Colors.black26,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: onTapSearch,
              child: const Icon(
                Icons.search_rounded,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
