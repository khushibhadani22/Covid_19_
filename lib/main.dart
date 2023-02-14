import 'package:flutter/material.dart';
import 'package:sky_scrapper_two/help.dart';

import 'details.dart';
import 'model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
      'detail': (context) => const Detail(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MYAppState();
}

class _MYAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "COVID-19",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: APIHelper.apiHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "ERROR :- ${snapshot.error}",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          } else if (snapshot.hasData) {
            Covid? data = snapshot.data;
            return (data != null)
                ? Container(
                    color: Colors.white,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: data.loc
                          .map((e) => Card(
                                margin: const EdgeInsets.all(8),
                                elevation: 3,
                                child: ListTile(
                                  tileColor: Colors.teal.shade700,
                                  textColor: Colors.white,
                                  title: Text(
                                    "${e['loc']}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('detail', arguments: e);
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : const Center(
                    child: Text(
                      "NO DATA....",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
