#import "NewsdkpluginPlugin.h"
#if __has_include(<newsdkplugin/newsdkplugin-Swift.h>)
#import <newsdkplugin/newsdkplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "newsdkplugin-Swift.h"
#endif

@implementation NewsdkpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNewsdkpluginPlugin registerWithRegistrar:registrar];
}
@end
