library flutter_rxbus;

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class RxBus {
  static RxBus _bus;
  Subject<dynamic> _subject;
  final List<StreamSubscription<dynamic>> _subscriptionsList =
  List<StreamSubscription<dynamic>>();

  static RxBus getInstance() {
    if (_bus == null) {
      _bus = RxBus();
    }
    return _bus;
  }

  RxBus() {
    _subject = new PublishSubject<dynamic>();
  }

  ///发送广播
  post(dynamic event) {
    if (_subject.hasListener) {
      _subject.add(event);
    }
  }

  ///返回指定类型的Observable
  Observable<T> toObservable<T>() {
    return _subject.stream.whereType<T>().cast();
  }

  ///注册
  void register<T>(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    _subscriptionsList.add(
        _subject.stream.whereType<T>().listen((t)=>onData(t),
            onError: onError, onDone: onDone, cancelOnError: cancelOnError)
    );
  }

  ///解除注册
  void unregister<T>(){
    ///临时存储要删除的subscription
    var tem = [];
    _subscriptionsList.forEach((StreamSubscription<dynamic> subscription){
      print("T 类型：" + T.toString() + "  subscription类型：" + subscription.toString());
      if(subscription.toString().contains(T.toString())){
        subscription.cancel();
        tem.add(subscription);
      }
    });
    tem.forEach((e){
      _subscriptionsList.remove(e);
    });
  }
}
