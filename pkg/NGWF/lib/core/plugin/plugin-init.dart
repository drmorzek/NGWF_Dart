class NGWFPlugin {
  dynamic G;
  String name;

  NGWFPlugin(this.name);

  setCtx(ctx) {
    G = ctx;
    return this;
  }

  setup() {}

  install() {
    setup();
    return this;
  }

  call() => this;
}
