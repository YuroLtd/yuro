import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:yuro/state/viewmodel.dart';

mixin SingleTickerMixin on ViewModel implements TickerProvider {
  Ticker? _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(() {
      if (_ticker == null) return true;
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$runtimeType is a SingleYuroControllerTickerMixin but multiple tickers were created.'),
        ErrorDescription('A SingleYuroControllerTickerMixin can only be used as a TickerProvider once.'),
        ErrorHint(
          'If a YuroController is used for multiple AnimationController objects, or if it is passed to other '
          'objects and those objects might use it more than one time in total, then instead of '
          'mixing in a SingleYuroControllerTickerMixin, use a regular YuroControllerTickerMixin.',
        )
      ]);
    }());
    _ticker = Ticker(onTick, debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
    return _ticker!;
  }

  void didChangeDependencies(BuildContext context) {
    if (_ticker != null) _ticker!.muted = !TickerMode.of(context);
  }

  @override
  void dispose() {
    assert(() {
      if (_ticker == null || !_ticker!.isActive) return true;
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$this was disposed with an active Ticker.'),
        ErrorDescription(
          '$runtimeType created a Ticker via its SingleYuroControllerTickerMixin, but at the time '
          'onDispose() was called on the mixin, that Ticker was still active. The Ticker must '
          'be disposed before calling super.onDispose().',
        ),
        ErrorHint(
          'Tickers used by AnimationControllers '
          'should be disposed by calling dispose() on the AnimationController itself. '
          'Otherwise, the ticker will leak.',
        ),
        _ticker!.describeForError('The offending ticker was'),
      ]);
    }());
    super.dispose();
  }
}

mixin TickerMixin on ViewModel implements TickerProvider {
  Set<Ticker>? _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_WidgetTicker>{};
    final result = _WidgetTicker(onTick, this, debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
    _tickers!.add(result);
    return result;
  }

  void _removeTicker(_WidgetTicker ticker) {
    assert(_tickers != null);
    assert(_tickers!.contains(ticker));
    _tickers!.remove(ticker);
  }

  void didChangeDependencies(BuildContext context) {
    final muted = !TickerMode.of(context);
    _tickers?.forEach((element) => element.muted = muted);
  }

  @override
  void dispose() {
    assert(() {
      _tickers?.forEach((element) {
        if (element.isActive) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('$this was disposed with an active Ticker.'),
            ErrorDescription(
              '$runtimeType created a Ticker via its YuroControllerTickerMixin, but at the time '
              'onDispose() was called on the mixin, that Ticker was still active. All Tickers must '
              'be disposed before calling super.onDispose().',
            ),
            ErrorHint(
              'Tickers used by AnimationControllers '
              'should be disposed by calling dispose() on the AnimationController itself. '
              'Otherwise, the ticker will leak.',
            ),
            element.describeForError('The offending ticker was'),
          ]);
        }
      });
      return true;
    }());
    super.dispose();
  }
}

class _WidgetTicker extends Ticker {
  _WidgetTicker(super.onTick, this._creator, {super.debugLabel});

  final TickerMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
