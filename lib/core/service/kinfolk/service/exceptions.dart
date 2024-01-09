class NullOrEmptyArgument extends Error {
  NullOrEmptyArgument(this.name);
  final String name;
  @override
  String toString() => '$name argument is Null or Empty';
}
