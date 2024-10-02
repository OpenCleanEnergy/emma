extension type const Watt(num _value) implements num {
  static const unit = "W";
  static const zero = Watt(0);

  // Json serialization
  factory Watt.fromJson(num json) => Watt(json);
  num toJson() => _value;
}
