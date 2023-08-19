import 'package:cat_cuisine/src/features/meals/data/isar_service.dart';
import 'package:cat_cuisine/src/features/meals/domain/cat.dart';
import 'package:cat_cuisine/src/features/meals/presentation/cat_card.dart';
import 'package:cat_cuisine/src/features/meals/utility/cat_utility.dart';
import 'package:flutter/material.dart';

class ManageCatScreen extends StatefulWidget {
  final IsarService service;

  const ManageCatScreen(this.service, {Key? key}) : super(key: key);

  @override
  State<ManageCatScreen> createState() => _ManageCatScreenState();
}

class _ManageCatScreenState extends State<ManageCatScreen> {
  final _catNameController = TextEditingController();

  @override
  void dispose() {
    _catNameController.dispose();
    super.dispose();
  }

  void _showAddCatDialog() {
    CatUtility.showAddCatDialog(context, _saveCat);
  }

  void _saveCat() {
    final catName = _catNameController.text;
    if (catName.isNotEmpty) {
      final newCat = Cat()..name = catName;
      widget.service.saveCat(newCat);
      _catNameController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$catName ist eingezogen!')),
      );
    }
  }

  void _deleteCat(Cat cat) {
    widget.service.deleteCat(cat);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${cat.name} hat das Hotel verlassen!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Katzenhotel'),
      ),
      body: FutureBuilder<List<Cat>>(
        future: widget.service.getAllCats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('An error occurred: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final cats = snapshot.data!;

            return ListView.builder(
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final cat = cats[index];
                return Dismissible(
                  key: ValueKey(cat.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: theme.colorScheme.error,
                    child: Icon(Icons.delete, color: theme.colorScheme.onError),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  onDismissed: (direction) => _deleteCat(cat),
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
                                  _deleteCat(cat);
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
                                  child: Image.network(
                                    'https://placekitten.com/100/100', // Increased size
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    cat.name ?? '',
                                    style: TextStyle(
                                        fontSize: 18), // Increased font size
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                );
              },
            );
          } else {
            return Center(child: Text('Keine Katzen gefunden'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCatDialog,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorScheme.background,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Katzenhotel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Mehr',
          ),
        ],
        onTap: (index) {
          // Handle navigation based on the selected index
        },
      ),
    );
  }
}
