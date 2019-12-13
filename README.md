# flutter_rxbus

A RxBus Flutter plugin.

## 用法(usage)

#### 在`pubspec.yaml`引入
```
flutter_rxbus ^0.0.1
```

#### 用法1、注册/解除注册 (usage 1、register/unregister)

```dart
    ///注册
    RxBus.getInstance().register<T>((value) {
        });

    @override
    void dispose() {
        ///解除注册 unregister
        RxBus.getInstance().unregister<T>();
        super.dispose();
    }
```
#### 用法2、获得指定类型Observable (usage 2、Get the specified type Observable)

```dart
    StreamSubscription _subscription;

    _subscription = RxBus.getInstance().toObservable<String>().listen((value) {
    });


    @override
    void dispose() {
        ///取消注册 unregister
        _subscription?.cancel();
        super.dispose();
    }
```

#### 发送Event (send event)
```dart
    RxBus.getInstance().post(T);
```
