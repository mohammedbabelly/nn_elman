import 'dart:io';
import 'Models/dataset.dart';
import 'Models/layer.dart';
import 'Models/neuralnetwork.dart';
import 'Models/neuron.dart';
import 'src/utils.dart' as utils;

var learningRate = 0.01;
var epochs = 100;
var input_n = 4;
var output_n = 1;
var layers_n = 3;
var hidden_layer_n = 8;
var context_n = hidden_layer_n;
var datasetName = "banknote";

void main(List<String> arguments) async {
  print('ELMAN');
  Neuron.setRange(0, 1);

  nn = NeuralNetwork([
    Layer([]), //input
    Layer.hidden(hidden_layer_n, input_n + context_n,
        ws: _generateWeights(input_n + context_n, hidden_layer_n,
            onesForContext: true),
        biasesWeights: _generateBiasWeights(hidden_layer_n),
        bias: _generateBiasValue()),
    Layer.hidden(output_n, hidden_layer_n,
        ws: _generateWeights(hidden_layer_n, output_n),
        biasesWeights: _generateBiasWeights(output_n),
        bias: _generateBiasValue())
  ]);

  var dataset = await loadDataset('train.txt', write: true);

  print('training...');
  train(dataset, epochs, learningRate);

  print('============');
  print('Output after training');
  print('============');
  for (var i in dataset.pairs) {
    forward(i.input_data);
    // print('inputs ${i.input_data}');
    var out = nn.layers[layers_n - 1].neurons.map((e) => e.value).toList();
    // var out = nn.layers[layers_n - 1].neurons[0].value;
    print('output: ' +
        utils.deNormalizeData(out).toString() +
        ' desired = ${i.output_data}');
    // afterData.add(utils.deNormalizeData(out)[output_n - 1]);
  }
  print('============');
  print('Predictiong');
  print('============');
  predict();
}

void predict() async {
  var success = 0;
  var all = 0;
  var datapredict = await loadDataset('test.txt');
  for (var i in datapredict.pairs) {
    forward(i.input_data);
    // print('for: ${i.input_data}');
    var out = nn.layers[layers_n - 1].neurons.map((e) => e.value).toList();
    var desired = utils.deNormalizeData(i.output_data);
    // var sortedOut = <double>[];
    // out.forEach((e) => sortedOut.add(e));
    // var predictIndex = -1;
    // sortedOut.sort();
    // for (int i = 0; i < out.length; i++) {
    //   if (out[i] == sortedOut[1]) predictIndex = i + 1;
    // }
    all++;
    if (out.first > 0.5) {
      //one prediction
      if (desired.first == 1) success++;
    } else if (desired.first == 0) success++;
    print('predict: ' +
        utils.deNormalizeData(out).toString() +
        ", desired: $desired}");
    // print('predict: ' +
    //     utils.deNormalizeData(out).toString() +
    //     ", desired: $desired}");
  }
  print('accurecy = ${(success * 100) / all}');
}

Future<Dataset> loadDataset(filename, {bool write = false}) async {
  var dataset = Dataset([]);
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

    // sampleOutput.addAll(_encodeOutPut(sampleInput.last.toInt()));
    sampleOutput.add(sampleInput.last);
    sampleInput.removeLast();
    allSamples.addAll(sampleInput + sampleOutput);
    dataset.pairs.add(Pair(sampleInput, sampleOutput));
  }
  // utils.minValue = allSamples.reduce(min);
  // utils.maxValue = allSamples.reduce(max);
  // for (var i = 0; i < dataset.pairs.length; i++) {
  //   dataset.pairs[i].input_data =
  //       utils.normalizeData(dataset.pairs[i].input_data);
  //   dataset.pairs[i].output_data =
  //       utils.normalizeData(dataset.pairs[i].output_data);
  // }
  dataset.pairs.shuffle();
  // var toWrite = '';
  // for (var i in dataset.pairs) toWrite += i.output_data[0].toString() + '\n';
  // if (write)
  //   await File('datasets/$datasetName/test/test.txt').writeAsString(toWrite);
  return dataset;
}

List<double> _encodeOutPut(int last) {
  var res = <double>[];
  switch (last) {
    case 1:
      {
        res = [1.0, 0.0, 0.0];
        break;
      }
    case 2:
      {
        res = [0.0, 1.0, 0.0];
        break;
      }
    case 3:
      {
        res = [0.0, 0.0, 1.0];
        break;
      }
  }
  return res;
}

List<List<double>> _generateWeights(int fi, int n,
    {bool onesForContext = false}) {
  List<List<double>> res = [];
  for (int i = 0; i < n; i++) {
    List<double> iRes = [];
    for (int j = 0; j < fi; j++) {
      iRes.add(utils.randomWeight((-2.4 / fi), (2.4 / fi)));
    }
    if (onesForContext)
      for (int i = input_n; i < n; i++) {
        iRes[i] = 1;
      }
    res.add(iRes);
  }
  return res;
}

List<double> _generateBiasWeights(int fi) {
  var res = <double>[];
  for (int i = 0; i < fi; i++) {
    res.add(utils.randomWeight((-2.4 / fi), (2.4 / fi)));
  }
  return res;
}

double _generateBiasValue() => (utils.randomWeight(-1, 1));
