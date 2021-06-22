class Neuron {
  // Static Neuron Attributes
  static int min_weight = 0;
  static int max_weight = 1;

  // Attributes
  List<double> weights = []; // Updated weights after backpropagation
  List<double> weights_old =
      []; // Weights before backpropagation (1 version older)
  double gradient;
  double bias;
  double value;
  double biasWeight;
  // Constructor for input neurons
  Neuron(double value) {
    this.weights = <double>[];
    this.weights_old = <double>[];
    this.bias = 1.0;
    this.gradient = 0.0;
    this.value = value;
  }

  // Constructor for hidden & output neurons
  Neuron.hidden(List<double> w, double bias, double biasWeight) {
    this.weights = List<double>.generate(w.length, (index) => 0.0);
    this.weights_old = w;
    this.bias = bias;
    this.gradient = 0.0;
    this.biasWeight = biasWeight;
  }

  // Update method (to be used after the backpropagation for updating weights)
  void updateWeights() {
    this.weights_old = this.weights;
  }

  static void setRange(int min, int max) {
    min_weight = min;
    max_weight = max;
  }
}
