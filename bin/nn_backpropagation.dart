import 'dart:io';
import 'dart:math';
import 'Models/dataset.dart';
import 'Models/layer.dart';
import 'Models/neuralnetwork.dart';
import 'Models/neuron.dart';
import 'src/utils.dart' as utils;

var learningRate = 0.05;
var epochs = 100000;
var input_n = 7;
var output_n = 1;
var layers_n = 3;
var datasetName = "wheat";
void main(List<String> arguments) async {
  var afterData = <double>[];
  Neuron.setRange(0, 1);

  var nn = NeuralNetwork(3); // 3 layers: 1 input + 2 hidden + 1 output
  // No need to add input layer, it will be added from dataset automatically
  // Hidden layer / 16 neurons each have 4 weights (connections)
  nn.layers[1] = Layer.hidden(8, input_n);
  // Output layer / 1 neuron with 10 weights (connections)
  nn.layers[2] = Layer.hidden(output_n, 8);

  var dataset = await loadDataset('train.txt');

  print('training...');
  train(nn, dataset, epochs, learningRate);

  print('============');
  print('Output after training');
  print('============');
  for (var i in dataset.pairs) {
    forward(nn, i.input_data);
    // print('inputs ${i.input_data}');
    var out = nn.layers[layers_n - 1].neurons[output_n - 1].value;
    print('output: ' + utils.deNormalizeData([out]).toString());
    afterData.add(utils.deNormalizeData([out])[output_n - 1]);
  }
  print('============');
  print('Predictiong');
  print('============');
  predict(nn);
}

void predict(NeuralNetwork nn) async {
  var datapredict = await loadDataset('test.txt');
  for (var i in datapredict.pairs) {
    forward(nn, i.input_data);
    // print('for: ${i.input_data}');
    var out = nn.layers[layers_n - 1].neurons[output_n - 1].value;
    print('predict: ' +
        utils.deNormalizeData([out])[output_n - 1].toString() +
        " the desired: ${utils.deNormalizeData([
              i.output_data[output_n - 1]
            ])}");
  }
}

Future<Dataset> loadDataset(filename) async {
  var dataset = Dataset();
  var data = await File('datasets/$datasetName/$filename').readAsString();
  var allSamples = <double>[];
  for (var rowData in data.split('\n')) {
    if (rowData.isEmpty) continue;
    var sampleInput = <double>[];
    var sampleOutput = <double>[];
    for (var feature in rowData.split(',')) {
      feature.replaceAll(' ', ''); //remove white spaces
      if (feature == '') continue;
      sampleInput.add(double.parse(feature));
    }
    sampleOutput.add(sampleInput.last);
    sampleInput.removeLast();
    allSamples.addAll(sampleInput + sampleOutput);
    dataset.pairs.add(Pair(sampleInput, sampleOutput));
  }
  utils.minValue = allSamples.reduce(min);
  utils.maxValue = allSamples.reduce(max);
  for (var i = 0; i < dataset.pairs.length; i++) {
    dataset.pairs[i].input_data =
        utils.normalizeData(dataset.pairs[i].input_data);
    dataset.pairs[i].output_data =
        utils.normalizeData(dataset.pairs[i].output_data);
  }
  return dataset;
}
