enum Env {
  dev("dev"),
  prod("prod");

  final String value;

  const Env(this.value);

  factory Env.fromString(String env) {
    switch (env) {
      case "prod":
        return Env.prod;
      default:
        return Env.dev;
    }
  }

  static Env get current => Env.fromString(const String.fromEnvironment("env"));
}
