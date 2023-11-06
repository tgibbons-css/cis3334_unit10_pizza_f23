import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Pizza> pizzasInOrder = [];

  void _addPizza() {
    final pizzaToppingTextField = TextEditingController();
    int? _sizeSelected = 1;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
                height:300,
                child:  Column(
                  children: <Widget>[
                    Text(
                      'Toppings:',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    TextField(
                      controller: pizzaToppingTextField,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    DropdownButton(
                        style: Theme.of(context).textTheme.headlineMedium,
                        value: _sizeSelected,
                        items:[
                          DropdownMenuItem(child: Text("Small"), value: 0),
                          DropdownMenuItem(child: Text("Medium"), value: 1),
                          DropdownMenuItem(child: Text("Large"), value: 2),
                          DropdownMenuItem(child: Text("X-Lareg"), value: 3)
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            _sizeSelected = value;
                          });
                        }),
                    ElevatedButton(
                      child: Text('Add Pizza'),
                      onPressed: () {
                        print("Adding a pizza");
                        setState(() {
                          Pizza newPizza = new Pizza(_sizeSelected!, pizzaToppingTextField.text);
                          pizzasInOrder.add(newPizza);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: pizzasInOrder.length,
          itemBuilder: (BuildContext context, int position) {
            return ListTile(
              title: Text(pizzasInOrder[position].description!),
              leading: Icon(Icons.restaurant_menu),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPizza,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Pizza {
  int _size;
  double? price;
  String? toppings;
  String? description;

  final PIZZA_PRICES = [7.99, 9.99, 12.99, 14.99];
  final PIZZA_SIZES = ["Small", "Medium", "Large", "X-Large"];

  Pizza(this._size, this.toppings){
    price = PIZZA_PRICES[_size];
    description = "${PIZZA_SIZES[_size]} $toppings Pizza";
    toppings = this.toppings;
  }

  @override
  String toString() {
    return (PIZZA_SIZES[_size] + toppings! + " Pizza");
  }

// Pizza(int size, String toppings) {
//    this.size = size;
//    this.toppings = toppings;
// }

}






