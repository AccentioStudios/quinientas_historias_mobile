extension CalculateRange2 on double {
  double calculateRangePercentage(
      {required double max, required double min, double? input}) {
    final double inputNotNull = input ?? this;
    double output = 0.0;
    if (!inputNotNull.isNegative && inputNotNull > min) {
      final mathsxd = (((inputNotNull - min) * 1.0) / (max - min));
      if (inputNotNull > min && inputNotNull < max) {
        output = mathsxd;
      }
      if (inputNotNull >= max) {
        output = max;
      }
      if (inputNotNull <= min) {
        output = 0.0;
      }
    } else {
      output = 0.0;
    }
    return output;
  }
}
