class Pair {
  List<double> input_data = [];
  List<double> output_data = [];

  Pair(this.input_data, this.output_data);
}

class Dataset {
  List<Pair> pairs;
  Dataset(this.pairs);
}
