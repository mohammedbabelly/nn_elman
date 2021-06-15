// Dataset loadDataset(List<List<dynamic>> list) {
//   Dataset dataset = new Dataset(); // Empty Dataset
//   for (int i = 0; i < list.length; i++) {
//     dataset.pairs.add(Pair([
//       //inputs
//       list[i][0].toDouble(),
//       list[i][1].toDouble(),
//       list[i][2].toDouble(),
//       list[i][3].toDouble(),
//       list[i][4].toDouble(),
//       list[i][5].toDouble(),
//       list[i][6].toDouble(),
//       list[i][7].toDouble(),
//       list[i][8].toDouble(),
//       list[i][9].toDouble(),
//       list[i][10].toDouble(),
//       list[i][11].toDouble(),
//       list[i][12].toDouble()
//     ], [
//       //outputs
//       list[i][13].toDouble()
//     ]));
//   }

//   return dataset;
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   void _loadCSV() async {
//     final _rawData = await rootBundle.loadString("assets/heart.csv");
//     List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
//     print(_listData);

//     // Set Min and Max weight value for all neurons
//     Neuron.setRange(-1, 1);

//     // Create a Neural Network with 3 Layers
//     NeuralNetwork nn = new NeuralNetwork(3); // 1 input + 1 hidden + 1 output
//     // No need to add input layer, it will be added from dataset automatically
//     nn.layers[1] = Layer.hidden(
//         4, 13); // Hidden layer / 6 neurons each have 2 weights (connections)
//     nn.layers[2] = Layer.hidden(
//         1, 4); // Output layer / 1 neuron with 6 weights (connections)

//     // Create the training data
//     Dataset dataset = loadDataset(_listData); // Hard-coded for now.

//     print("============");
//     print("Output before training");
//     print("============");
//     for (var i in dataset.pairs) {
//       forward(nn, i.input_data);
//       print('inputs: ' +
//           nn.layers[0].neurons[0].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[1].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[2].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[3].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[4].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[5].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[6].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[7].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[8].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[9].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[10].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[11].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[12].value.toString() +
//           ', ');
//       print('output: ' + nn.layers[2].neurons[0].value.toString());
//     }

//     train(nn, dataset, 2000, 0.05);

//     print("============");
//     print("Output after training");
//     print("============");
//     for (var i in dataset.pairs) {
//       forward(nn, i.input_data);
//       print('inputs: ' +
//           nn.layers[0].neurons[0].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[1].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[2].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[3].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[4].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[5].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[6].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[7].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[8].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[9].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[10].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[11].value.toString() +
//           ', ' +
//           nn.layers[0].neurons[12].value.toString() +
//           ', ');
//       print('output: ' + nn.layers[2].neurons[0].value.toString());
//     }
//   }
// }
