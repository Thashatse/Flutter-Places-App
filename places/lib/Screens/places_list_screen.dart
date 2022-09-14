import 'package:flutter/material.dart';
import 'package:places/Screens/add_place_screen.dart';
import 'package:provider/provider.dart';
//Providers
import 'package:places/Providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Padding(
                      padding: EdgeInsets.all(25),
                      child: Center(
                        child: Text('No place yet :('),
                      ),
                    ),
                    builder: (context, greatPlaces, child) =>
                        greatPlaces.items.isEmpty
                            ? child!
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: ((context, index) {
                                  final item = greatPlaces.items[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(item.image),
                                    ),
                                    title: Text(item.title),
                                    onTap: (() {
                                      //go te detail screen
                                    }),
                                  );
                                }),
                              ),
                  ),
      ),
    );
  }
}
