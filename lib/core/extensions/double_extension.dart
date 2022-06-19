extension CalculateRange2 on double {
  double calculateRangePercentage(
      {required double max, required double min, double? input}) {
    final double _input = input ?? this;
    double output = 0.0;
    if (!_input.isNegative && _input > min) {
      final mathsxd = (((_input - min) * 1.0) / (max - min));
      if (_input > min && _input < max) {
        output = mathsxd;
      }
      if (_input >= max) {
        output = max;
      }
      if (_input <= min) {
        output = 0.0;
      }
    } else {
      output = 0.0;
    }
    return output;
  }
}
