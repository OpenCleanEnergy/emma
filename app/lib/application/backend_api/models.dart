extension type const Watt(num value) implements num {
  static const Watt zero = Watt(0);

  // Json serialization
  factory Watt.fromJson(num json) => Watt(json);
  num toJson() => value;
}
