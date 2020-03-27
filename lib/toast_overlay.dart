part of 'utopic_toast.dart';

/// [ToastOverlay] initialize and dispose [ToastManager] toast controller
///
/// [ToastOverlay] should be inside [MaterialApp] to get [Theme.of(context)]
///
/// EXAMPLE:
/// ```dart
/// MaterialApp(
///   ...
///   builder: (context, child) {
///     return ToastOverlay(child: child);
///   },
///   ...
/// );
/// ```
/// {@end-tool}
/// {@tool sample}
class ToastOverlay extends StatelessWidget {
  /// Toast successfull type background color
  ///
  /// default is [Colors.green]
  final Color successfullBackgroundColor;

  /// Toast successfull type text color
  ///
  /// default is [Colors.white] with opacity 0.87
  final Color successfullTextColor;

  /// Toast warning type background color
  /// default is [Colors.deepOrange]
  final Color warningBackgroundColor;

  /// Toast warning type text color
  ///
  /// default is [Colors.white] with opacity 0.87
  final Color warningTextColor;

  /// Toast error type background color
  /// default is [Colors.red]
  final Color errorBackgroundColor;

  /// Toast error type text color
  ///
  /// default is [Colors.white] with opacity 0.87
  final Color errorTextColor;

  /// Toast normal notification type background color
  ///
  /// default is inversed theme card color
  final Color normalBackgroundColor;

  /// Toast normal notification type text color
  ///
  /// default is inversed theme text color
  final Color normalTextColor;

  /// Is toast should be wrapped with Dismissible
  ///
  /// default is [true]
  final bool enableSwipeToDismiss;

  /// Is toast should be hide on tap
  ///
  /// default is [false]
  final bool enableTapToHide;

  final Widget child;

  const ToastOverlay({
    Key key,
    this.child,
    this.successfullBackgroundColor,
    this.successfullTextColor,
    this.warningBackgroundColor,
    this.warningTextColor,
    this.errorBackgroundColor,
    this.errorTextColor,
    this.normalBackgroundColor,
    this.normalTextColor,
    this.enableSwipeToDismiss = true,
    this.enableTapToHide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top + 8;

    return Provider<ToastOverlay>.value(
      value: this,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          child,
          SafeArea(
            child: Theme(
              data: _generateInverseTheme(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: StreamBuilder<List<ToastFuture>>(
                  stream: ToastManager()._toastsController,
                  builder: (context, toastsSnapshot) {
                    return AnimatedList(
                      key: ToastManager()._toastAnimatedListKey,
                      initialItemCount: toastsSnapshot.data?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index, animation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                -statusBarHeight * (1 - animation.value),
                              ),
                              child: child,
                            );
                          },
                          child: SizeTransition(
                            sizeFactor: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: toastsSnapshot.data
                                  .elementAt(index)
                                  ._toastCard,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ThemeData _generateInverseTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isThemeDark = theme.brightness == Brightness.dark;

    final Brightness brightness =
        isThemeDark ? Brightness.light : Brightness.dark;
    final Color themeBackgroundColor = isThemeDark
        ? colorScheme.onSurface
        : Color.alphaBlend(
            colorScheme.onSurface.withOpacity(0.80), colorScheme.surface);

    return ThemeData(
      cardTheme: theme.cardTheme,
      brightness: brightness,
      backgroundColor: themeBackgroundColor,
      colorScheme: ColorScheme(
        primary: colorScheme.onPrimary,
        primaryVariant: colorScheme.onPrimary,
        secondary:
            isThemeDark ? colorScheme.primaryVariant : colorScheme.secondary,
        secondaryVariant: colorScheme.onSecondary,
        surface: colorScheme.onSurface,
        background: themeBackgroundColor,
        error: colorScheme.onError,
        onPrimary: colorScheme.primary,
        onSecondary: colorScheme.secondary,
        onSurface: colorScheme.surface,
        onBackground: colorScheme.background,
        onError: colorScheme.error,
        brightness: brightness,
      ),
    );
  }
}
