import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.blueAccent
          )
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Profile UI"),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green[300],
                      Colors.green[50]
                    ]
                )
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("images/nabeel.jpg"),
                  ),
                ) ,
                Expanded(
                  child: ListView(

                    children: <Widget>[

                      ListTile(

                          title: Center(child: Text("Nabeel Javed", style: TextStyle(fontSize: 20.0),)),
                          subtitle: Center(child: Text("Android and Web Developer", style: TextStyle(fontSize: 20.0),))
                      ),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                          RaisedButton(
                            onPressed: (){

                            },
                            child: Text("Message ME"),
                            color: Colors.red,
                            textColor: Colors.white,
                            elevation: 6.0,
                          ),
                          RaisedButton(
                            onPressed: (){

                            },
                            child: Text("Hire Me"),
                            color: Colors.red,
                            textColor: Colors.white,
                            elevation: 6.0,
                          ),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text("About Me", style: TextStyle(fontSize: 18.0),),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "over 2.5 years of experience in developing android and web applications; "
                                  "i have good coomand in android java, kotlin, laravel, php, node-js, bootstrap and rest api also making cross platform "
                                  "apps with flutter integrate with firebase, laravel and node-js Api's. apart from it proficient in databases desin and implementation as backend "
                                  "for web and mobile apps. morever good knowledge of ui/ux concepts with software engineering "
                                  "principle such as drafting SRS and SDS."
                              ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}