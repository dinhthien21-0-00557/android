import 'package:flutter/material.dart';
import 'package:mvvm_sqlite_demo/model/major.dart';
import 'major_item.dart';
import 'major_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MajorScreen extends StatelessWidget {
  final _majorVM = MajorViewModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _majorVM,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Major'),
            actions: [
              IconButton(
                  onPressed: () => _showEditDialog(context, _majorVM),
                  icon: Icon(Icons.add))
            ],
          ),
          body: _listMajors(),
        ));
  }

  Widget _listMajors() => ScopedModelDescendant<MajorViewModel>(
        builder: (BuildContext context, Widget? child, MajorViewModel model) {
          return ListView.builder(
            itemCount: model.majors.length,
            itemBuilder: (context, index) {
              return MajorItem(
                major: model.majors[index],
                onClick: (major) =>
                    _showEditDialog(context, model, major: major),
                onDelete: (major) => model.delete(major),
              );
            },
          );
        },
      );
  final _majorNameController = TextEditingController();

  Future<void> _showEditDialog(var context, MajorViewModel model,
      {Major? major}) async {
    major ??= Major(name: '');
    _majorNameController.text = major.name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter major name'),
            content: TextField(
              controller: _majorNameController,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10)),
            ),
            actions: [
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  Navigator.pop(context);
                  major!.name = _majorNameController.text.trim();
                  model.save(major);
                },
              )
            ],
          );
        });
  }
}
