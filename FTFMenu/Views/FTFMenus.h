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
///FTFMenus
@interface FTFMenus : UIView
///三角形的位置,默认FTFMenusStationUPLeft
@property(nonatomic,assign)FTFMenusStation menuStation;
///标题样式,默认文字
@property(nonatomic,assign)FTFMenusType menuStyle;
///cell的高度,默认是当前视图高度的0.23
@property(nonatomic,assign)CGFloat currentRowHeight;
///标题数组
@property(nonatomic,strong)NSArray<NSString *> *titleSource;
///图片名称数组,在枚举FTFMenusImage下才使用,并且个数要和titleSource相同
@property(nonatomic,strong)NSArray<NSString *> *imageData;
//是否可以滑动
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
