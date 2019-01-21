import 'package:flutter/material.dart';
import 'package:fancy_widgets/fancy_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Widgets Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fancy Widgets Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RoundIconButton(
                    color: Colors.white,
                    backgroundColor: Colors.red,
                    radius: 28.0,
                    elevation: 10.0,
                    icon: Icons.content_cut,
                    onPressed: () {
                      print('Pressed!!');
                    },
                  ),
                  RoundIconButton(
                    color: Colors.white,
                    backgroundColor: Colors.green,
                    radius: 28.0,
                    elevation: 10.0,
                    icon: Icons.content_copy,
                    onPressed: () {
                      print('Pressed!!');
                    },
                  ),
                  RoundIconButton(
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    radius: 28.0,
                    elevation: 10.0,
                    icon: Icons.content_paste,
                    onPressed: () {
                      print('Pressed!!');
                    },
                  ),
                ],
              ),
              RibbonBannerButton(
                text: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.new_releases,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                    ),
                    Text('Button 1',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
                width: 300,
                height: 60,
                color: Colors.red,
                elevation: 10.0,
                onPressed: () {
                  print('Pressed');
                },
              ),
              RibbonBannerButton(
                text: Text(
                  'Button 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
                splashColor: Colors.purple.withOpacity(.3),
                width: 300,
                height: 60,
                color: Colors.green,
                elevation: 10.0,
                onPressed: () {
                  print('Pressed');
                },
              ),
              RibbonBannerButton(
                text: Text('Button 3'),
                width: 300,
                height: 60,
                color: Colors.blue,
                elevation: 10.0,
                onPressed: () {
                  print('Pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
