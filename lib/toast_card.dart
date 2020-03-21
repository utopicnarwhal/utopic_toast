part of 'utopic_toast.dart';

class _ToastCard extends StatelessWidget {
  final String message;
  final ToastAction action;
  final ToastType type;

  const _ToastCard({
    Key key,
    this.message,
    this.action,
    this.type,
  })  : assert(key != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastOverlay toastOverlay;
    try {
      toastOverlay = Provider.of<ToastOverlay>(context);
    } on ProviderNotFoundException catch (e) {
      print(e);
    }

    Color backgroundColor;
    Color textColor;
    switch (type) {
      case ToastType.success:
        backgroundColor =
            toastOverlay?.successfullBackgroundColor ?? Colors.green;
        textColor = toastOverlay?.successfullTextColor ??
            Colors.white.withOpacity(0.87);
        break;
      case ToastType.warning:
        backgroundColor =
            toastOverlay?.warningBackgroundColor ?? Colors.deepOrange;
        textColor =
            toastOverlay?.warningTextColor ?? Colors.white.withOpacity(0.87);
        break;
      case ToastType.error:
        backgroundColor = toastOverlay?.errorBackgroundColor ?? Colors.red;
        textColor =
            toastOverlay?.errorTextColor ?? Colors.white.withOpacity(0.87);
        break;
      case ToastType.notification:
        backgroundColor =
            toastOverlay?.normalBackgroundColor ?? Theme.of(context).cardColor;
        textColor = toastOverlay?.normalTextColor;
        break;
      default:
    }

    Widget result = Card(
      color: backgroundColor.withOpacity(0.97),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.left,
                style: TextStyle(color: textColor),
              ),
            ),
            action?.build(
                  context,
                  () => ToastManager()._hideToastByKey(key),
                ) ??
                SizedBox(),
          ],
        ),
      ),
    );

    if (toastOverlay?.enableSwipeToDismiss != false) {
      result = Dismissible(
        key: key,
        onDismissed: (_) {
          ToastManager()._hideToastByKey(key, showAnim: false);
        },
        child: result,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: result,
    );
  }
}
