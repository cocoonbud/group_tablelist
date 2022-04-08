#import "GroupTablelistPlugin.h"
#if __has_include(<group_tablelist/group_tablelist-Swift.h>)
#import <group_tablelist/group_tablelist-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "group_tablelist-Swift.h"
#endif

@implementation GroupTablelistPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGroupTablelistPlugin registerWithRegistrar:registrar];
}
@end
