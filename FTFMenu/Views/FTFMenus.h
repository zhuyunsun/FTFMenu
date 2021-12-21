//
//  FTFMenus.h
//  FTFMenu
//
//  Created by 朱运 on 2021/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#pragma mark 主要视图
///三角形位置
typedef NS_ENUM(NSUInteger,FTFMenusStation){
    //上方
    FTFMenusStationUPLeft = 1, //default
    FTFMenusStationUPMiddle,
    FTFMenusStationUPRight,

    //左边
    FTFMenusStationLeftUP,
    FTFMenusStationLeftMiddle,
    FTFMenusStationLeftDown,

    //下边
    FTFMenusStationDownLeft,
    FTFMenusStationDownMiddle,
    FTFMenusStationDownRight,

    //右边
    FTFMenusStationRightUP,
    FTFMenusStationRightMiddle,
    FTFMenusStationRightDown,

    
};

///显示的样式
typedef NS_ENUM(NSUInteger,FTFMenusType){
    FTFMenusWord,//单纯文字 default
    FTFMenusImage,//文字 + 图片
};

@protocol FTFMenusDelegate;
///FTFMenus
@interface FTFMenus : UIView

///三角形的位置,默认FTFMenusStationUPLeft
@property(nonatomic,assign)FTFMenusStation menuStation;

///标题样式,默认文字
@property(nonatomic,assign)FTFMenusType menuStyle;

///cell的高度,不设置默认是当前UITableView视图高度的0.25
@property(nonatomic,assign)CGFloat currentRowHeight;

///标题数组
@property(nonatomic,strong)NSArray<NSString *> *titleSource;

///图片名称数组,在枚举FTFMenusImage下才使用,并且个数要和titleSource相同
@property(nonatomic,strong)NSArray<NSString *> *imageData;

///设置三角形图标的x坐标,仅在上和下2个位置生效,不设置时取对应的默认值
@property(nonatomic,assign)CGFloat currentMinx;

///设置三角形图标的y坐标,仅在左右2个位置生效,不设置去对应默认值;
@property(nonatomic,assign)CGFloat currentMinY;

///获取三角形视图的宽度和高度,高度=宽度;
@property(nonatomic,readonly,assign)CGFloat trigonDefaultHeight;

///协议
@property(nonatomic,weak)id <FTFMenusDelegate>delegate;

///是否可以滑动,默认yes
@property(nonatomic,assign,getter=isSlide)BOOL canSlide;

///加载动画效果,默认yes
@property(nonatomic,assign,getter=isShowAnimate)BOOL showAnimate;

///移除当前界面(带有动画效果)
-(void)hideRemoveView:(FTFMenus *)view;

@end

@protocol FTFMenusDelegate <NSObject>

@optional
/// 选中的标题下标,从0开始
/// @param index 下标
-(void)selectFTFIndex:(NSUInteger)index;
@end

//====================================================================================

#pragma mark 子视图:三角形
typedef NS_ENUM(NSInteger,FTFArrowState){
    FTFArrowStateRight = 1,
    FTFArrowStateLeft,
    FTFArrowStateUp,
    FTFArrowStateDown,
};
@interface FTFMiddleView : UIView
@property(nonatomic,assign)FTFArrowState state;
@end

//====================================================================================

#pragma mark 自定义cell

@interface FTFMenusCell : UITableViewCell
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *logoImageView;

///重写方法,需要UITableView的cell的宽度和高度
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size cellStyle:(FTFMenusType)cellStyle;
@end







NS_ASSUME_NONNULL_END
