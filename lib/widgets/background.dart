part of 'widgets.dart';

class Background extends StatelessWidget {
  Background({
    super.key,
    required this.tinggi,
    required this.lebar,
    required this.child
  });

  Widget child;

  final double tinggi;
  final double lebar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tinggi,
      width: lebar,
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.onPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
