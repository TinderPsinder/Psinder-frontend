import 'package:flutter/material.dart';

extension FutureLoader on NavigatorState {
  Future<T> futureLoader<T>(Future<T> future) => push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              _FutureLoaderWidget(future: future),
          opaque: false,
        ),
      );
}

class _FutureLoaderWidget<T> extends StatefulWidget {
  const _FutureLoaderWidget({@required Future<T> future, Key key})
      : assert(future != null),
        _future = future,
        super(key: key);

  final Future<T> _future;

  @override
  __FutureLoaderWidgetState createState() => __FutureLoaderWidgetState();
}

class __FutureLoaderWidgetState extends State<_FutureLoaderWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _waitForFuture());
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black.withOpacity(0.5),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: CircularProgressIndicator(),
        ),
      );

  Future<void> _waitForFuture() async {
    final result = await widget._future;
    Navigator.pop(context, result);
  }
}
