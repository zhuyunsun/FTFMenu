//
//  BaseStyleController.h
//  FTFMenu
//
//  Created by 朱运 on 2021/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_STATIC_INLINE CGFloat WINDOWHEIGHT(){
    return [UIScreen mainScreen].bounds.size.height;
}
UIKIT_STATIC_INLINE CGFloat WINDOWWIDTH(){
    return [UIScreen mainScreen].bounds.size.width;
}
@interface BaseStyleController : UIViewController

@end

NS_ASSUME_NONNULL_END
