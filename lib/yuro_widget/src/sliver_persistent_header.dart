import 'package:flutter/material.dart';

/// 不能用在slivers中作为第一个子widget,否则会报错
class SliverPersistentHeaderBuilder extends StatelessWidget {
  SliverPersistentHeaderBuilder({
    required this.builder,
    required this.maxHeight,
    this.minHeight,
    this.rebuild,
    this.pinned = false,
    this.floating = false,
  });

  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;
  final double maxHeight;
  final double? minHeight;
  final bool Function(SliverPersistentHeaderDelegate oldDelegate)? rebuild;
  final bool pinned;
  final bool floating;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
      delegate: _SliverPersistentHeaderDelegate(builder, maxHeight, minHeight ?? maxHeight, rebuild),
      pinned: pinned,
      floating: floating);
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;
  final double maxHeight;
  final double minHeight;
  final bool Function(SliverPersistentHeaderDelegate oldDelegate)? rebuild;

  _SliverPersistentHeaderDelegate(this.builder, this.maxHeight, this.minHeight, this.rebuild);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      builder.call(context, shrinkOffset, overlapsContent);

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => rebuild?.call(oldDelegate) ?? false;
}
