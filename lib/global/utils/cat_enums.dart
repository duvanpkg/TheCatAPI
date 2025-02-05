enum Intelligence {
  veryLow(1), // Very Low
  low(2), // Low
  average(3), // Medium
  high(4), // High
  veryHigh(5); // Very High

  final int value;

  const Intelligence(this.value);

  @override
  String toString() {
    switch (this) {
      case Intelligence.veryLow:
        return "Very Low";
      case Intelligence.low:
        return "Low";
      case Intelligence.average:
        return "Medium";
      case Intelligence.high:
        return "High";
      case Intelligence.veryHigh:
        return "Very High";
    }
  }
}

// Enum for adaptability
enum Adaptability {
  low(1), // Very Low
  average(2), // Low
  aboveAverage(3), // Medium
  high(4), // High
  veryHigh(5); // Very High

  final int value;

  const Adaptability(this.value);

  @override
  String toString() {
    switch (this) {
      case Adaptability.low:
        return "Very Low";
      case Adaptability.average:
        return "Low";
      case Adaptability.aboveAverage:
        return "Medium";
      case Adaptability.high:
        return "High";
      case Adaptability.veryHigh:
        return "Very High";
    }
  }
}
