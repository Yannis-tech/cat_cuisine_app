import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatCard extends ConsumerWidget {
  final Cat cat; // Add this line
  TextEditingController ageController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController otherFactsController = TextEditingController();

  CatCard({required this.cat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    // Method to show avatar selection
    Future<void> showAvatarSelection() async {
      List<String> avatars = [
        'assets/pictures/Cat_01.png',
        'assets/pictures/Cat_02.png',
        'assets/pictures/Cat_03.png',
        'assets/pictures/Cat_04.png',
        'assets/pictures/Cat_05.png',
        'assets/pictures/Cat_06.png',
        'assets/pictures/Cat_07.png',
        'assets/pictures/Cat_08.png',
        'assets/pictures/Cat_09.png'
      ];

      // Show dialog or navigate to a selection screen
      String? selectedAvatar = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose an Avatar'),
            content: SingleChildScrollView(
              child: ListBody(
                children: avatars.map((String avatar) {
                  final assetPath = '$avatar';
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(assetPath),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(assetPath),
                          colorFilter:
                              ColorFilter.mode(Colors.black, BlendMode.dstOver),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
      // Update cat's picture if an avatar is selected
      if (selectedAvatar != null) {
        cat.picturePath = selectedAvatar;
        final isarService = ref.read(isarServiceProvider);
        await isarService.updateCat(cat);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text(cat.name ?? 'Unnamed Cat', style: theme.textTheme.headline6),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 320,
                    width: 320,
                    child: cat.picturePath != null
                        ? Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('${cat.picturePath}'),
                                colorFilter: ColorFilter.mode(
                                  Colors.black,
                                  BlendMode.dstOver,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/pictures/Cat_01.png'),
                                colorFilter: ColorFilter.mode(
                                  Colors.black,
                                  BlendMode.dstOver,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: theme.colorScheme.primary,
                      onPressed: showAvatarSelection,
                      child:
                          Icon(Icons.edit, color: theme.colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Cat's name
              Text(
                cat.name ?? 'Unnamed Cat',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Placeholder text for statistics or facts
              Text(
                'Statistics/Facts: Your cat\'s statistics and facts will be shown here.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Input field for age
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age (years)'),
                ),
              ),
              SizedBox(height: 16),
              // Input field for birthday
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: birthdayController,
                  decoration: InputDecoration(labelText: 'Birthday'),
                ),
              ),
              SizedBox(height: 16),
              // Input field for other facts
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: otherFactsController,
                  decoration: InputDecoration(labelText: 'Other Facts'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
