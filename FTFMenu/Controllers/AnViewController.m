//
//  AnViewController.m
//  FTFMenu
//
//  Created by 朱运 on 2021/12/1.
//

#import "AnViewController.h"
#import "FTFMenus.h"
@interface AnViewController (){
    UIView *upLine;
    UIView *leftLine;
    UIView *downLine;
    UIView *rightLine;
    
    CGFloat minX;
    CGFloat upWidth;
    CGFloat leftHeight;
    
    
    FTFMenus *menu;
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
    
    UIView *middleView = [[UIView alloc]init];
    middleView.frame = CGRectMake(0, 0,middleWidth, middleHeight);
    middleView.center = CGPointMake(lessWidth / 2, lessHeight / 2);
    middleView.backgroundColor = [UIColor clearColor];
    [lessView addSubview:middleView];
    
    //
    CGFloat btnWidth = middleWidth * 0.28;
    CGFloat btnMiddleWidth = (middleWidth - btnWidth *3) / 2;
    CGFloat btnHeight = middleHeight *0.1;
    CGFloat btnMiddleHeight = middleHeight *0.04;
    
    NSUInteger tag = 100000;
    NSUInteger index = 0;
    NSArray *titleArr = @[@"上-左",@"上-中",@"上-右",
                          @"左-上",@"左-中",@"左-下",
                          @"下-左",@"下-中",@"下-右",
                          @"右-上",@"右-中",@"右-下"];
    for (NSUInteger i = 0; i < 4; i ++) {
        
        for (NSUInteger j = 0; j < 3; j ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((btnWidth + btnMiddleWidth) *j, (btnMiddleHeight + btnHeight) *i, btnWidth, btnHeight);
            btn.backgroundColor = [UIColor blackColor];
            btn.tag = tag;
            btn.layer.cornerRadius = 5;
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
    
    [menu removeFromSuperview];
    menu = nil;
    
    
    
    CGRect r1 = CGRectMake(upWidth *0.3,CGRectGetMaxY(upLine.frame) + 2, upWidth *0.4, leftHeight * 0.9);
    menu = [[FTFMenus alloc]initWithFrame:r1];
    menu.titleSource = @[@"测试中标题1",@"测试中标题2",@"测试中标题3",@"测试中标题4",@"测试中标题5"];
//    menu.menuStyle = FTFMenusImage;
    menu.imageData = @[@"A1",@"A1",@"A1",@"A1",@"A1"];
    menu.alpha = 0.01;
    [self.view addSubview:menu];
    
    [UIView animateWithDuration:0.33 animations:^{
        menu.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    //
    if (tag == 0) {
        
    }
    if (tag == 1) {
        menu.menuStation =  FTFMenusStationUPMiddle;
    }
    if (tag == 2) {
        menu.menuStation =  FTFMenusStationUPRight;
    }
    //
    if (tag == 3) {
        menu.menuStation = FTFMenusStationLeftUP;
    }
    if (tag == 4) {
        menu.menuStation = FTFMenusStationLeftMiddle;
    }
    if (tag == 5) {
        menu.menuStation = FTFMenusStationLeftDown;
    }
    //
    if (tag == 6) {
        menu.menuStation = FTFMenusStationDownLeft;
    }
    if (tag == 7) {
        menu.menuStation = FTFMenusStationDownMiddle;
    }
    if (tag == 8) {
        menu.menuStation = FTFMenusStationDownRight;
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
    }
//    menu.currentRowHeight = leftHeight * 0.7 *0.4;
    
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
