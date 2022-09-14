import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
//Providers
import 'package:places/Providers/great_places.dart';
//widgets
import 'package:places/Widgets/image_imput.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = "/add-place";

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  late File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: Text('Requiered Field Incompleate'),
          content: Text('A Title and Image are requiered'),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            )
          ],
        ),
      );
      return;
    }

    Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place'),
        actions: [],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Tiltle'),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ImageInput(onSelectImage: _selectImage)
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: _savePlace,
              label: Text('Add Place'),
              icon: Icon(Icons.add),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
            )
          ]),
    );
  }
}
