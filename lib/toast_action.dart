part of 'utopic_toast.dart';

class ToastAction {
  final String label;
  final Color textColor;
  final Color disabledTextColor;
  final void Function(void Function()) onPressed;

  const ToastAction({
    Key key,
    this.onPressed,
    this.disabledTextColor,
    this.label,
    this.textColor,
  });

  Widget build(BuildContext context, void Function() hideToast) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: TextButton(
        onPressed: () => onPressed(hideToast),
        child: Text(label),
      ),
    );
  }
}
