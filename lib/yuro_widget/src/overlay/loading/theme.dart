part of 'loading.dart';

class LoadingTheme {
  final Widget loadingWidget;
  final Color barrierColor;

  LoadingTheme({
    this.loadingWidget = const DefaultLoading(),
    this.barrierColor = Colors.black54,
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
