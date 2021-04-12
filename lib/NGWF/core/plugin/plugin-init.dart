class NGWFPlugin {
  dynamic G;
  String name;

  NGWFPlugin(this.name) {}

  setCtx(ctx) {
    this.G = ctx;
    return this;
  }

  setup() {}

  install() {
    this.setup();
    return this;
  }

  call() => this;
}
