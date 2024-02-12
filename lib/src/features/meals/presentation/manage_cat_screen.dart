import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/presentation/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/providers.dart';
import '../utility/cat_utility.dart';

class ManageCatScreen extends ConsumerWidget {
  void _showAddCatDialog(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(manageCatProvider);
    CatUtility.showAddCatDialog(context, (String catName) {
      viewModel.saveCat(catName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$catName ist eingezogen!')),
      );
    });
  }

  void _deleteCat(BuildContext context, WidgetRef ref, Cat cat) {
    final viewModel = ref.read(manageCatProvider);
    viewModel.deleteCat(cat).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${cat.name} hat das Hotel verlassen!')),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(manageCatProvider);
    var theme = Theme.of(context);

    return Scaffold(
      body: viewModel.isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show a loader while the cats are being loaded
          : viewModel.cats.isEmpty
              ? Center(child: Text('Keine Katzen gefunden'))
              : ListView.builder(
                  itemCount: viewModel.cats.length,
                  itemBuilder: (context, index) {
                    final cat = viewModel.cats[index];
                    return Dismissible(
                      key: ValueKey(cat.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: theme.colorScheme.error,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete,
                            color: theme.colorScheme.onError),
                      ),
                      onDismissed: (direction) => _deleteCat(context, ref, cat),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Oh nein!'),
                            content: Text(
                                'Soll ${cat.name} wirlich das Hotel verlassen?'),
                            actions: [
                              TextButton(
                                child: Text('Nein'),
                                onPressed: () => Navigator.of(ctx).pop(false),
                              ),
                              TextButton(
                                child: Text('Ja'),
                                onPressed: () => Navigator.of(ctx).pop(true),
                              ),
                            ],
                          ),
                        );
                      },
                      child: GestureDetector(
                          onTap: () {
                            // Update the provider with the selected cat
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CatCard(cat: cat),
                              ),
                            );
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Oh nein!'),
                                content: Text(
                                    'Soll ${cat.name} wirlich das Hotel verlassen?'),
                                actions: [
                                  TextButton(
                                    child: Text('Nein'),
                                    onPressed: () => Navigator.of(ctx).pop(),
                                  ),
                                  TextButton(
                                    child: Text('Ja'),
                                    onPressed: () {
                                      _deleteCat(context, ref, cat);
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: cat.picturePath != null
                                          ? Container(
                                              alignment: Alignment.center,
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      cat.picturePath!),
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black,
                                                      BlendMode.dstOver),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/pictures/Cat_01.png'),
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black,
                                                      BlendMode.dstOver),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        cat.name ?? '',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCatDialog(context, ref),
        child: Icon(Icons.add),
        backgroundColor: theme.colorScheme.secondaryContainer,
      ),
    );
  }
}
