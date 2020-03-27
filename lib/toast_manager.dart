part of 'utopic_toast.dart';

/// Singleton class that controls a toasts
class ToastManager {
  static final ToastManager _toastServiceSingleton = ToastManager._internal();

  factory ToastManager() {
    return _toastServiceSingleton;
  }
  ToastManager._internal();

  final _toastAnimatedListKey = GlobalKey<AnimatedListState>();
  final BehaviorSubject<List<ToastFuture>> _toastsController =
      BehaviorSubject<List<ToastFuture>>.seeded([]);

  ToastFuture showToast(
    String message, {
    ToastType type = ToastType.notification,
    ToastAction action,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (_toastsController == null) {
      print('Toast manager is not initialized');
      return null;
    }
    if (message == null) {
      print('No message');
      return null;
    }

    final toastFuture = ToastFuture._(
      _ToastCard(
        key: UniqueKey(),
        message: message,
        action: action,
        type: type,
      ),
    );

    _toastAnimatedListKey.currentState?.insertItem(0);
    _toastsController?.add([
      toastFuture,
      ..._toastsController.value,
    ]);

    Future.delayed(duration, () {
      hideToast(toastFuture);
    });

    return toastFuture;
  }

  void hideToast(ToastFuture toastFuture, {showAnim = true}) async {
    if (_toastsController == null) {
      print('Toast manager is not initialized');
      return;
    }
    if (toastFuture == null) {
      print('No toastFuture');
      return;
    }
    if (_toastsController.value?.contains(toastFuture) != true) {
      return;
    }

    _toastAnimatedListKey.currentState?.removeItem(
      _toastsController.value.indexOf(toastFuture),
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: toastFuture._toastCard,
          ),
        );
      },
      duration: showAnim ? Duration(milliseconds: 300) : Duration.zero,
    );
    _toastsController.add(
      _toastsController.value..remove(toastFuture),
    );
  }

  void _hideToastByKey(Key toastKey, {showAnim = true}) async {
    if (_toastsController == null) {
      print('Toast manager is not initialized');
      return;
    }
    if (toastKey == null) {
      print('No toastFuture');
      return;
    }
    var toastFuture = _toastsController.value?.firstWhere(
      (toastFuture) => toastFuture._toastCard.key == toastKey,
      orElse: () => null,
    );
    hideToast(toastFuture, showAnim: showAnim);
  }
}
