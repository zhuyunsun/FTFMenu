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
    //
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:vc];
    
    //iOS15默认导航栏黑色.
    if (@available(iOS 15.0, *)) {
        //iOS15设置导航栏颜色
        UINavigationBarAppearance *bar = [[UINavigationBarAppearance alloc]init];
        [bar configureWithOpaqueBackground];
        bar.backgroundColor = [UIColor whiteColor];
        bar.shadowColor = [UIColor lightGrayColor];
        na.navigationBar.standardAppearance = bar;
        
        //滑动才正常,设置不滑动也正常
        na.navigationBar.scrollEdgeAppearance = bar;
        
        
    } else {
        
    }
    self.window.rootViewController = na;
    return YES;
}
@end
