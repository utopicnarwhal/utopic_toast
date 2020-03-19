library utopic_toast;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

part 'toast_manager.dart';
part 'toast_overlay.dart';
part 'toast_card.dart';
part 'toast_future.dart';

enum ToastType {
  error,
  success,
  warning,
  notification,
}
