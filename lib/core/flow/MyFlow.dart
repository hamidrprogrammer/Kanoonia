class MyFlow<T> {
  const MyFlow(this.flow);

  final Function(T) flow;

  void emit(T appState) {
    flow.call(appState);
  }
}
