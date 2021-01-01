import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Homepage()));

class Homepage extends StatefulWidget {
  @override
  _Homepagestate createState() => _Homepagestate();
}

class _Homepagestate extends State<Homepage> {
  String Stringrespon;
  List Listresponse;
  Map Mapresponse;
  List Listfacts;

  Future fetchData() async {
    http.Response response;
    response = await http.get('https://thegrowingdeveloper.org/apiview?id=2');
    if (response.statusCode == 200) {
      setState(() {
        Mapresponse = jsonDecode(response.body);
        Listfacts = Mapresponse['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch data'),
        backgroundColor: Colors.blue,
      ),
      body: Mapresponse == null
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    Mapresponse['category'].toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image.network(Listfacts[index]['image_url']),
                            Text(
                              Listfacts[index]['title'].toString(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Listfacts[index]['description'].toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: Listfacts == null ? 0 : Listfacts.length,
                  )
                ],
              ),
            ),
    );
  }
}
