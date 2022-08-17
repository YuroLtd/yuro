import 'package:example/export.dart';
import 'package:flutter/material.dart';

class ExpandableTextDemo extends StatelessWidget {
  const ExpandableTextDemo({super.key});

  static const _text =
      '韩立可是货真价实的童男，被“陈师妹”的一阵亲吻后，就觉得心中一荡，一种异样的感觉涌了上来。'
      '再加上，他从不标榜自己是什么正人君子，对坐怀不乱那一套也不屑去做，所以有些情动的他，'
      '毫不客气的反手楼住了“陈师妹”**的身体，手指更在其光滑如丝的肌肤上大肆抚动起来。';

  static const _text2 =
      '韩立可是货真价实的童男，被“陈师妹”的一阵亲吻后，\n就觉得心中一荡，一种异样的感觉涌了上来。\n'
      '再加上，他从不标榜自己是什么正人君子，对坐怀不乱那一套也不屑去做，所以有些情动的他，\n'
      '毫不客气的反手楼住了“陈师妹”**的身体，手指更在其光滑如丝的肌肤上大肆抚动起来。';


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appBar(title: context.localizations.expandableText),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.5.w),
          color: Colors.grey[200],
          child: const Text('效果总览'),
        ),
        Padding(
          padding: EdgeInsets.all(12.w),
          child: const ExpandableText(content: _text),
        ),
        Padding(
          padding: EdgeInsets.all(12.w),
          child: const ExpandableText(content: _text2),
        ),
      ]));
}
