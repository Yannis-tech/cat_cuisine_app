import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final Cat cat;

  CatCard({required this.cat});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name ?? 'Katzendetails',
            style: theme.textTheme.titleSmall),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://placekitten.com/100/100'),
            Text(cat.name ?? '', style: theme.textTheme.displaySmall),
            // Add more details here
          ],
        ),
      ),
    );
  }
}
