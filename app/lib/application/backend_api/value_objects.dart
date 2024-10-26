extension type const Percentage(num _value) implements num {
  static const unit = "%";
  static const zero = Percentage(0);

  // Json serialization
  factory Percentage.fromJson(num json) => Percentage(json);
  num toJson() => _value;
}

extension type const Watt(num _value) implements num {
  static const unit = "W";
  static const zero = Watt(0);

  // Json serialization
  factory Watt.fromJson(num json) => Watt(json);
  num toJson() => _value;
}

extension type const WattHours(num _value) implements num {
  static const unit = "Wh";
  static const zero = WattHours(0);

  // Json serialization
  factory WattHours.fromJson(num json) => WattHours(json);
  num toJson() => _value;
}
