import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String url = 'http://10.0.2.2:8000/api/blog';
  // alt url http://10.0.2.2

  Future getBlogs() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: FutureBuilder(
        future: getBlogs(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                return Container(
                  height: 180,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Image.network(snapshot.data['data'][index]['thumbnail']),
                        ),
                        Text(snapshot.data['data'][index]['title'], style: TextStyle(fontSize: 16),),
                        SizedBox(
                          width: 50.0,
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
            });
          }else{
            return Text("Data Error");
          }
        },
      )
    );
  }
}
