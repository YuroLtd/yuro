part of 'loading.dart';

class LoadingTheme {
  final Color barrierColor;
  final Widget child;

  LoadingTheme({
    this.barrierColor = Colors.black54,
    this.child = const DefaultLoading(),
  });
}

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CircularProgressIndicator(color: Yuro.theme.primaryColor, strokeWidth: 3),
        ),
      );
}
