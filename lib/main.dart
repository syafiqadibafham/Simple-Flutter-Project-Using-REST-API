import 'package:colors/people_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late People starWarsCharacters;
  String longText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac libero tempus, aliquet mauris vel, mollis lectus. Quisque molestie arcu sapien, sit amet mollis urna vestibulum ut. In commodo finibus massa. Suspendisse potenti. Sed pulvinar fermentum enim, a auctor massa ornare ac. Donec malesuada suscipit orci, eu porta lacus venenatis eget. Maecenas sed nulla nisl. Donec dictum, sapien sed vulputate vestibulum, risus neque pellentesque dui, non condimentum neque nulla non nisl. Duis vitae iaculis nisi. Morbi condimentum aliquam lorem, dignissim congue felis tincidunt at. Nullam mattis turpis sit amet vestibulum vestibulum. Quisque eleifend iaculis odio, at luctus turpis tempus et. Praesent nec efficitur nisi. Nunc vel dictum mauris, id facilisis eros. Proin molestie consequat nulla, id efficitur neque maximus ac. Donec at purus a dui ornare tempus eget nec arcu. Nam orci magna, ullamcorper vitae ultrices vitae, tempor sed nunc. Donec iaculis est neque, et dapibus tellus porttitor posuere. Aliquam interdum, ligula quis ultrices ultrices, elit arcu fermentum lacus, eu imperdiet mi augue ut elit. Ut rhoncus sagittis vulputate. Nulla ut arcu sed nunc pretium tincidunt. Nulla placerat orci ligula, sodales accumsan est ornare a. Aliquam ante ante, facilisis ac ultricies ac, laoreet in nunc. Fusce sollicitudin gravida ante, in ultricies neque suscipit a. Nullam fringilla tortor quis nisl lacinia, vitae sagittis nisl fringilla. Curabitur accumsan id metus a congue. Donec viverra risus odio, sit amet condimentum orci porttitor non. Aliquam erat volutpat. Sed ac nisi ornare sapien pharetra faucibus. Nullam porttitor eleifend lacus, id auctor libero varius id. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce commodo dolor sed nisi consectetur, ac sodales urna finibus. Integer nec felis quis eros consequat accumsan ac in ante. Phasellus auctor odio tellus, in accumsan purus dapibus nec. Maecenas tempus viverra convallis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum ut ligula mi. Aenean hendrerit ipsum sed ante consequat, vitae semper nibh consequat. Etiam bibendum leo ut urna semper finibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur eget tincidunt sapien, in vulputate sem. Vestibulum egestas ex et justo ornare, eu pulvinar magna tincidunt. Fusce dictum nulla urna, id facilisis nibh bibendum et. Nullam eget venenatis neque. Vestibulum a neque at ante tempus posuere at in tellus. Aliquam vitae mollis justo. Mauris turpis nunc, tempus in tincidunt sed, ullamcorper ac nibh. Phasellus eget ligula dictum, ullamcorper ligula id, ullamcorper lorem. Curabitur quis molestie neque. Integer ut odio faucibus, scelerisque lectus et, pulvinar urna. Sed porttitor lectus ornare nibh pellentesque molestie. Vivamus auctor lacinia elit vitae eleifend. Aenean elementum, lacus non rhoncus congue, leo risus lacinia ligula, sed dignissim ligula nulla vitae tellus. Cras ipsum dui, vestibulum nec porttitor ac, ornare vel velit. Curabitur vel magna dui. Quisque porta tincidunt tellus, quis fringilla tellus dictum eu. Sed porttitor convallis nisi, ac sollicitudin dolor bibendum ut. Nunc nisi ligula, posuere vel tincidunt id, lobortis ut turpis. Nam scelerisque sit amet purus a porttitor.";
  bool isShowMore = false;

  void _incrementCounter() {
    setState(() {
      getPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ExpandableText(),
              FutureBuilder<People>(
                  future: getPeople(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: 400,
                        child: ListView(
                          shrinkWrap: true,
                          children:
                              snapshot.data!.name.map((e) => Text(e)).toList(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return Center(child: const CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget ExpandableText() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        isShowMore ? longText.substring(0, 100) : longText,
      ),
      ElevatedButton(
        onPressed: () {
          setState(() {
            isShowMore = !isShowMore;
          });
        },
        child: Text(
          isShowMore ? "Show More" : "Show less",
        ),
      )
    ]);
  }
}
