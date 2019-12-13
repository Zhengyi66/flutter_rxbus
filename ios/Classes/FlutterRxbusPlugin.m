#import "FlutterRxbusPlugin.h"
#import <flutter_rxbus/flutter_rxbus-Swift.h>

@implementation FlutterRxbusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterRxbusPlugin registerWithRegistrar:registrar];
}
@end
