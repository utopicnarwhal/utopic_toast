part of 'utopic_toast.dart';

class ToastFuture {
  final _ToastCard _toastCard;

  ToastFuture._(
    this._toastCard,
  );

  void dismiss() {
    ToastManager().hideToast(this);
  }
}
