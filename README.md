# utopic_toast

Toast Flutter package.

You are free to correct my English!

###  Overview

- In the true sense of Toast, you can call it whenever you need it, without any restrictions.

- Showing multiple dismissible toasts at the same time with showing and hiding animation.

- Pure flutter implementation, it is not easy to bring compatibility problems

### Preview

![ezgif com-resize](https://user-images.githubusercontent.com/8808766/77065247-fe239100-69f1-11ea-9eba-c9808e00d8ca.gif)

### Getting started

#### 1. add dependencies into you project pubspec.yaml file
``` dart
dependencies:
     utopic_toast: ^0.1.3
```

#### 2. import BotToast lib
``` dart
import 'package:utopic_toast/utopic_toast.dart';
```

#### 3. initialization ToastOverlay
``` dart
// wrap MaterialApp builder's child with ToastOverlay and set your custom params
MaterialApp(
  ...
  builder: (context, child) {
    return ToastOverlay(child: child);
  },
  ...
);
```

#### 4. use ToastManager
``` dart
var toastFuture = ToastManager().showToast(
  'YOUR MESSAGE TO USER',
  type: ToastType.error, // set toast type to change presetted theme color 
  action: ToastAction(
    label: 'HAY',
    onPressed: (hideToastFn) {
      print('yay');
      hideToastFn();
    },
  ),
  duration: Duration(seconds: 3),
);
```

```dart
toastFuture.dismiss(); // to hide toast
```
