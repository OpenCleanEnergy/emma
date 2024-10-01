extension type const Watt(num value) {
  static const Watt zero = Watt(0);

  bool operator >(Watt other) => value > other.value;

  // Json serialization
  factory Watt.fromJson(num json) => Watt(json);
  num toJson() => value;
}
