typedef InstanceBuilder<T> = T Function();

class InstanceBuilderFactory<T> {
  // builder是否是单例
  bool isSingleton;

  // 当[isSingleton]=true时存储实际对象实例
  T? dependency;

  // 当[isSingleton]=false时生成（或重新生成）实例。
  InstanceBuilder<T> builder;

  String? tag;

  // 是否完成初始化
  bool isInit;

  // 重复put同一个对象时,旧的对象存放此处
  InstanceBuilderFactory<T>? lateRemove;

  // 是否污染的
  bool isDirty = false;

  // 是否是永久实例
  bool permanent;

  // 删除时是否保存Factory
  bool keepFactory;

  InstanceBuilderFactory({
    required this.builder,
    required this.tag,
    required this.isSingleton,
    required this.isInit,
    required this.lateRemove,
    required this.permanent,
    required this.keepFactory,
  });

  T getDependency() => isSingleton ? dependency ??= builder.call() : builder.call();
}