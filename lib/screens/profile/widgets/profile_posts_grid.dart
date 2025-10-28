
import 'package:flutter/material.dart';

class ProfilePostsGrid extends StatelessWidget {
  const ProfilePostsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9, // Dummy data
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Image.network(
          'https://picsum.photos/seed/${index + 100}/200/200',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
