import '../src/utils.dart' as utils;

import 'neuron.dart';

class Layer {
  List<Neuron> neurons = [];

  // Constructor for input layers
  Layer(List<double> inputs) {
    for (int i = 0; i < inputs.length; i++) {
      this.neurons.add(Neuron(inputs[i]));
    }
  }

  // Constructor for hidden & output layers
  Layer.hidden(int number_of_neurons, int weights_per_neuron) {
    for (int i = 0; i < number_of_neurons; i++) {
      List<double> weights = [];
      for (var j = 0; j < weights_per_neuron; j++) {
        weights.add(utils.randomWeight(Neuron.min_weight, Neuron.max_weight));
      }
      double bias = utils.randomWeight(0, 1);
      this.neurons.add(Neuron.hidden(weights, bias));
    }
  }
}
