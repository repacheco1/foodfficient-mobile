import 'package:flutter/material.dart';
import 'package:foodfficient/models/pantryFunctions.dart';
import 'package:foodfficient/models/pantryModel.dart';
import 'package:foodfficient/widgets/addItem.dart';

class PantryList extends StatelessWidget{
  final List<Pantry> cabinet;
  final PantryPresenter pantryPresenter;

  PantryList(
    this.cabinet,
    this.pantryPresenter,
    {Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: cabinet == null ? 0 : cabinet.length,
      itemBuilder: (BuildContext context, int index){
        return new Card(
          child:  new Container(
            child: new Center(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: new Text(
                        getShortName(cabinet[index]),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                    title: Text(
                      '${cabinet[index].name} ${cabinet[index].qtyType}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Exp Date: ${cabinet[index].expDate}', //modify this function if cards are broken
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children :<Widget>[
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(Icons.edit),
                            onPressed: () => edit(cabinet[index], context),
                          ),
                          FlatButton(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              ),
                              // 
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder:(BuildContext context){
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    title: Text(
                                      'Delete from pantry list?',
                                    ),
                                    content: Text(
                                      'This will delete "${cabinet[index].name.toLowerCase()}" from your pantry list.'
                                    ),
                                    actions: <Widget>[
                                      RaisedButton(
                                        child: Text(
                                          'Cancel'
                                        ),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        color: Colors.blueGrey,
                                        textColor: Colors.white,
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        splashColor: Colors.grey,
                                      ),
                                      RaisedButton(
                                        child: Text(
                                          'Delete'
                                        ),
                                        onPressed: (){
                                          pantryPresenter.delete(cabinet[index]);
                                          Navigator.pop(context);
                                        },
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        splashColor: Colors.grey,
                                      ),
                                    ],
                                  );
                                }
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  displayRecord() {
    pantryPresenter.updateScreen();
  }

  edit(Pantry pantry, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddPantryItem().buildPantryDialog(context, this, true, pantry),
    );
    pantryPresenter.updateScreen();
  }

  String getShortName(Pantry pantry) {
    String shortName = "";
    if (pantry.name.isNotEmpty) {
      shortName = pantry.name.substring(0, 1);
    }
    return shortName;
  }
}
