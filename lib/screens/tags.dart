import 'package:myapp/providers/note_providers.dart';
import 'package:flutter/material.dart';

class TagPage extends StatefulWidget {
  @override
  TagPageState createState() {
    return new TagPageState();
  }
}

class TagPageState extends State<TagPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: TagProvider.getTagList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final tags = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, left: 22.0, right: 22.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(tags[index]['tag']),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await TagProvider.deleteTag(
                                      tags[index]['id']);
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: tags.length,
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
