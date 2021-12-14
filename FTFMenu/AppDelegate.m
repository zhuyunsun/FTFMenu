//
//  AppDelegate.m
//  FTFMenu
//
//  Created by 朱运 on 2021/12/1.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = na;
    return YES;
}
@end
