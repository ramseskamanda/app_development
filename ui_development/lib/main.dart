import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.86,
            heightFactor: 0.9,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Center(child: Page2());
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: const Text('Hello'),
            onPressed: () {
              print('Hello');
            },
          ),
        )
      ],
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/portrait.jpeg',
            height: 100,
            fit: BoxFit.fitWidth,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Studentup'),
              Switch.adaptive(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
          Input(),
          const SizedBox(height: 16.0),
          Input(),
          const SizedBox(height: 16.0),
          Input(),
          const SizedBox(height: 16.0),
          Input(),
          const SizedBox(height: 16.0),
          Button(),
          Button(),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/portrait.jpeg',
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                "title that is kinda long and even longer now",
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.bold)
                    .apply(
                        color: Theme.of(context)
                            .textTheme
                            .display1
                            .color
                            .withAlpha(255)),
              ),
              const SizedBox(height: 16.0),
              Text(
                "description that is slighlty longer but still not insane",
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Opacity(
                opacity: 0.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Button(),
        ),
      ],
    );
  }
}
