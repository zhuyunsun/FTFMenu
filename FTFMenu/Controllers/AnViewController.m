//
//  AnViewController.m
//  FTFMenu
//
//  Created by 朱运 on 2021/12/1.
//

#import "AnViewController.h"
#import "FTFMenus.h"
@interface AnViewController ()<FTFMenusDelegate>{
    UIView *upLine;
    UIView *leftLine;
    UIView *downLine;
    UIView *rightLine;
    
    CGFloat minX;
    CGFloat upWidth;
    CGFloat leftHeight;
    
    UIView *middleView;
    FTFMenus *menu;
    CGFloat menuWidth;
    CGFloat menuHeight;
    
    NSArray *titleArr;
    
    NSUInteger selecetBtn;
    
}

@end

@implementation AnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     三角形的菜单栏,先确定三种样式:三角形在右边,三角形在中间,三角形在左边
     
     如果讨论四个方向的话,起码的12种
     */
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //
    [self addLines];
    
    //
    CGFloat lessWidth = WINDOWWIDTH() - 40;
    CGFloat lessHeight = WINDOWHEIGHT() *0.5;
    CGFloat lessMaxY = CGRectGetMaxY(downLine.frame) + WINDOWHEIGHT() *0.05;
    CGRect lessRect = CGRectMake(20, lessMaxY,lessWidth, lessHeight);
    
    UIView *lessView = [[UIView alloc]init];
    lessView.backgroundColor = [UIColor lightGrayColor];
    lessView.frame = lessRect;
    lessView.layer.cornerRadius = 5;
    [self.view addSubview:lessView];
    
    //
    CGFloat middleLess = lessWidth *0.03;
    CGFloat middleWidth = lessWidth - middleLess *2;
    CGFloat middleHeight = lessHeight - middleLess *2;
    
    middleView = [[UIView alloc]init];
    middleView.frame = CGRectMake(0, 0,middleWidth, middleHeight);
    middleView.center = CGPointMake(lessWidth / 2, lessHeight / 2);
    middleView.backgroundColor = [UIColor clearColor];
    [lessView addSubview:middleView];
    
    //
    CGFloat btnWidth = middleWidth * 0.28;
    CGFloat btnMiddleWidth = (middleWidth - btnWidth *3) / 2;
    CGFloat btnHeight = middleHeight *0.1;
    CGFloat btnMiddleHeight = middleHeight *0.04;
    
    selecetBtn = 50;
    
    NSUInteger tag = 100000;
    NSUInteger index = 0;
    titleArr = @[@"上-左",@"上-中",@"上-右",
                 @"左-上",@"左-中",@"左-下",
                 @"下-左",@"下-中",@"下-右",
                 @"右-上",@"右-中",@"右-下",
                 @"自定义x坐标",@"自定义y坐标",@"加载没有动画效果",
                 @"标题不可滑动",@"不带图片的标题",@"自定义标题栏高度"];
    for (NSUInteger i = 0; i < 6; i ++) {
        
        for (NSUInteger j = 0; j < 3; j ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((btnWidth + btnMiddleWidth) *j, (btnMiddleHeight + btnHeight) *i, btnWidth, btnHeight);
            btn.backgroundColor = [UIColor blackColor];
            btn.tag = tag;
            btn.layer.cornerRadius = 5;
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
            [middleView addSubview:btn];
//            NSLog(@"btn的tag值 = %ld",tag);
            tag ++;
            
            //
            if (index < titleArr.count) {
                [btn setTitle:titleArr[index] forState:UIControlStateNormal];
            }
            index ++;
        }
        
    }
    
}
-(void)btnAction:(UIButton *)btn{
    NSLog(@"点击的tag = %ld",btn.tag);
    NSUInteger tag = btn.tag - 100000;
    if (selecetBtn == 50) {
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderColor = [[UIColor blackColor] CGColor];
        btn.layer.borderWidth = 0.88;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        selecetBtn = btn.tag;
    }else{
        if (selecetBtn != btn.tag) {
            //上一个点击的
            [self normalState];
            //当前点击的
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.borderColor = [[UIColor blackColor] CGColor];
            btn.layer.borderWidth = 0.88;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            selecetBtn = btn.tag;
        }else{
            NSLog(@"点击了相同的按钮");
            return;
        }
        
    }
    
    
    
    self.title = titleArr[tag];
    
    [menu removeFromSuperview];
    menu = nil;
    
    
    menuWidth = upWidth *0.4;
    menuHeight = leftHeight * 0.9;
    CGRect r1 = CGRectMake(upWidth *0.3,CGRectGetMaxY(upLine.frame) + 2,menuWidth, menuHeight);
    menu = [[FTFMenus alloc]initWithFrame:r1];
    menu.titleSource = @[@"测试中标题1",@"测试中标题2",@"测试中标题3",@"测试中标题4",@"测试中标题5"];
    menu.menuStyle = FTFMenusImage;
    menu.imageData = @[@"A1",@"A1",@"A1",@"A1",@"A1"];
    menu.alpha = 0.01;
    menu.delegate = self;
    NSLog(@"三角图标的默认宽高 = %f",menu.trigonDefaultHeight);
    //
    if (tag == 0) {
        //上-左
        menu.canSlide = NO;
    }
    if (tag == 1) {
        //上-中
        menu.menuStation =  FTFMenusStationUPMiddle;
        menu.currentMinx = menuWidth;
    }
    if (tag == 2) {
        //上-右
        menu.menuStation =  FTFMenusStationUPRight;
    }
    //
    if (tag == 3) {
        //左-上
        menu.menuStation = FTFMenusStationLeftUP;
        menu.currentMinY = menuHeight *0.5;
    }
    if (tag == 4) {
        menu.menuStation = FTFMenusStationLeftMiddle;
    }
    if (tag == 5) {
        menu.menuStation = FTFMenusStationLeftDown;
    }
    
    //所有属性设置都在add之前
    menu.alpha = 1;
    [self.view addSubview:menu];
    
    [UIView animateWithDuration:0.33 animations:^{
        
        } completion:^(BOOL finished) {
            
        }];


    //
    if (tag == 6) {
        menu.menuStation = FTFMenusStationDownLeft;
        menu.currentMinx = menuWidth - menu.trigonDefaultHeight - 4;
    }
    if (tag == 7) {
        menu.menuStation = FTFMenusStationDownMiddle;
    }
    if (tag == 8) {
        menu.menuStation = FTFMenusStationDownRight;
        menu.currentMinx = menuWidth *0.5;
    }
    //
    if (tag == 9) {
        menu.menuStation = FTFMenusStationRightUP;
    }
    if (tag == 10) {
        menu.menuStation = FTFMenusStationRightMiddle;
    }
    if (tag == 11) {
        menu.menuStation = FTFMenusStationRightDown;
        menu.canSlide = NO;
        menu.showAnimate = NO;
//        menu.currentRowHeight = menuHeight *0.2;
    }
//    menu.currentRowHeight = menuHeight *0.4;
    //
    
    
}

- (void)selectFTFIndex:(NSUInteger)index{
    NSLog(@"返回的Index下标 = %ld",index);
    [self normalState];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"FTF__%s", __PRETTY_FUNCTION__);
    [menu hideRemoveView:menu];
    [self normalState];
}
-(void)normalState{
    UIButton *oldBtn = (UIButton *)[middleView viewWithTag:selecetBtn];
    oldBtn.backgroundColor = [UIColor blackColor];
    [oldBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}
-(void)addLines{
    minX = WINDOWWIDTH() *0.15;
    upWidth = WINDOWWIDTH() - minX *2;
    leftHeight = WINDOWHEIGHT()* 0.25;
    
    CGFloat lineWidth = 1.8;
    UIColor *lineColor = [UIColor blackColor];
    
    upLine = [[UIView alloc]init];
    upLine.frame = CGRectMake(minX, WINDOWHEIGHT() *0.05, upWidth, lineWidth);
    upLine.backgroundColor = lineColor;
    [self.view addSubview:upLine];
    
    
    leftLine = [[UIView alloc]init];
    leftLine.frame = CGRectMake(minX, WINDOWHEIGHT() *0.05 + 2, lineWidth, WINDOWHEIGHT()* 0.25);
    leftLine.backgroundColor = lineColor;
    [self.view addSubview:leftLine];
    
    
    downLine = [[UIView alloc]init];
    downLine.frame = CGRectMake(minX, WINDOWHEIGHT() *0.05 + leftHeight + 2, upWidth, lineWidth);
    downLine.backgroundColor = lineColor;
    [self.view addSubview:downLine];

    rightLine = [[UIView alloc]init];
    rightLine.frame = CGRectMake(minX + upWidth, WINDOWHEIGHT() *0.05 + 2, lineWidth, WINDOWHEIGHT()* 0.25);
    rightLine.backgroundColor = lineColor;
    [self.view addSubview:rightLine];

    
}
@end
