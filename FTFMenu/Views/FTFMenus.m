//
//  FTFMenus.m
//  FTFMenu
//
//  Created by 朱运 on 2021/12/10.
//

#import "FTFMenus.h"



#pragma mark FTFMenus
@interface FTFMenus()<UITableViewDelegate,UITableViewDataSource>{
    FTFMiddleView *m1;
    //
    CGFloat trigonHeight;
    NSArray *arrData;
    NSArray *arrImage;
    UITableView *myTableView;
    
    
    CGFloat width;
    CGFloat height;
    CGFloat rowHeight;//cell的高度,根据mainView高度来决定
    CGFloat rowWidth;
    
    FTFMenusType currentStyle;
    FTFMenusStation currentStation;
}
@end
@implementation FTFMenus
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        /*
         1,三角形图案,尖角三种位置
         2,列表:包含文字,图案 + 文字
         3,加载的位置,由自己决定
         
         
         是否需要设置行数?可滑动?
         弹出和隐藏进行动画效果?单例进行一层封装?
         
         
         视图布局根据不同的类型进行布局,
         还有一个是图片或者单纯文字.、
         
         4个方向,4种不同的布局.
         */
        
        width = frame.size.width;
        height = frame.size.height;
        
        self.backgroundColor = [UIColor clearColor];
        trigonHeight = 12;//三角形的高度
        
        //默认 UP views
        currentStyle = FTFMenusWord;
        currentStation = FTFMenusStationUPLeft;
        
        [self reloadLineView];
        
    }
    return self;
}
//重新对myTableView和三角形视图进行布局
-(void)reloadLineView{
    //4个方向
    CGFloat mainWidth = 0;
    CGFloat mainHeight = 0;
    CGRect r0 = CGRectZero;
    
    CGRect r1 = CGRectZero;
    FTFArrowState state = FTFArrowStateUp;
    //上边
    if (currentStation == FTFMenusStationUPLeft || currentStation == FTFMenusStationUPMiddle || currentStation == FTFMenusStationUPRight) {
        mainWidth = width;
        mainHeight = height - trigonHeight;

        rowHeight = mainHeight *0.23;
        rowWidth = mainWidth;
        r0 = CGRectMake(0, trigonHeight, mainWidth, mainHeight);
        
        
        state = FTFArrowStateUp;
        //要细分
        if (currentStation == FTFMenusStationUPLeft){
            r1 = CGRectMake(trigonHeight, 0, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationUPMiddle){
            r1 = CGRectMake(width / 2 - trigonHeight, 0, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationUPRight){
            r1 = CGRectMake(width  - trigonHeight *2, 0, trigonHeight, trigonHeight);
        }
    }
    //左边
    if (currentStation == FTFMenusStationLeftUP || currentStation == FTFMenusStationLeftMiddle || currentStation == FTFMenusStationLeftDown) {
        mainWidth = width - trigonHeight;
        mainHeight = height;

        rowHeight = mainHeight *0.23;
        rowWidth = mainWidth;
        r0 = CGRectMake(trigonHeight,0, mainWidth, mainHeight);
        
        
        state = FTFArrowStateLeft;
        if (currentStation == FTFMenusStationLeftUP){
            r1 = CGRectMake(0,trigonHeight, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationLeftMiddle){
            r1 = CGRectMake(0,height / 2 - trigonHeight / 2, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationLeftDown){
            r1 = CGRectMake(0, height - trigonHeight *2, trigonHeight, trigonHeight);
        }

    }
    //下边
    if (currentStation == FTFMenusStationDownLeft || currentStation == FTFMenusStationDownMiddle || currentStation == FTFMenusStationDownRight) {
        mainWidth = width;
        mainHeight = height - trigonHeight;

        rowHeight = mainHeight *0.23;
        rowWidth = mainWidth;
        r0 = CGRectMake(0,0, mainWidth, mainHeight);

        state = FTFArrowStateDown;
        if (currentStation == FTFMenusStationDownLeft){
            r1 = CGRectMake(trigonHeight,height - trigonHeight, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationDownMiddle){
            r1 = CGRectMake(width / 2 - trigonHeight,height - trigonHeight, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationDownRight){
            r1 = CGRectMake(width  - trigonHeight *2,height - trigonHeight, trigonHeight, trigonHeight);
        }

    }
    //右边
    if (currentStation == FTFMenusStationRightUP || currentStation == FTFMenusStationRightMiddle || currentStation == FTFMenusStationRightDown) {
        mainWidth = width - trigonHeight;
        mainHeight = height;

        rowHeight = mainHeight *0.23;
        rowWidth = mainWidth;
        r0 = CGRectMake(0,0, mainWidth, mainHeight);
        
        
        state = FTFArrowStateRight;
        if (currentStation == FTFMenusStationRightUP){
            r1 = CGRectMake(width - trigonHeight,trigonHeight, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationRightMiddle){
            r1 = CGRectMake(width - trigonHeight,height / 2 - trigonHeight / 2, trigonHeight, trigonHeight);
        }
        if (currentStation == FTFMenusStationRightDown){
            r1 = CGRectMake(width - trigonHeight, height - trigonHeight *2, trigonHeight, trigonHeight);
        }


    }

    [myTableView removeFromSuperview];
    myTableView = nil;
    myTableView = [[UITableView alloc]init];
    myTableView.frame = r0;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.tableFooterView = [[UIView alloc]init];
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.layer.cornerRadius = 3;
    [self addSubview:myTableView];
    
    [m1 removeFromSuperview];
    m1 = nil;
    m1 = [[FTFMiddleView alloc]initWithFrame:r1];
    m1.state = state;
    [self addSubview:m1];


}

#pragma mark delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击的row = %ld",indexPath.row);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  rowHeight;
}
- (FTFMenusCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"FTFStr";
    FTFMenusCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[FTFMenusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str size:CGSizeMake(rowWidth, rowHeight) cellStyle:currentStyle];
    }
    if (indexPath.row < arrData.count) {
        cell.titleLabel.text = arrData[indexPath.row];
    }
    if (currentStyle == FTFMenusImage) {
        if (indexPath.row < arrImage.count) {
            cell.logoImageView.image = [UIImage imageNamed:arrImage[indexPath.row]];
        }
    }
    return cell;
}

//
- (void)setTitleSource:(NSArray *)titleSource{
    arrData = [titleSource copy];
    if (arrData.count > 0) {
        [myTableView reloadData];
    }
}
- (void)setImageData:(NSArray *)imageData{
    if (currentStyle == FTFMenusImage) {
        arrImage = [imageData copy];
        if (arrImage.copy > 0) {
            [myTableView reloadData];
        }
    }
}
- (void)setMenuStyle:(FTFMenusType)menuStyle{
    //设置了图片样式,移除init中创建的tableView,重新创建,把类型传进FTFMenusCell
    //重新加载tableView,也重新加载三角形视图,写在一起了.
    if (menuStyle == FTFMenusImage) {
        currentStyle = menuStyle;
        [self reloadLineView];
    }
}
- (void)setCurrentRowHeight:(CGFloat)currentRowHeight{
    rowHeight = currentRowHeight;
    //刷新行不行?
    [myTableView reloadData];
}
- (void)setMenuStation:(FTFMenusStation)menuStation{
        /*
         2个组合?
         还是直接枚举12种组合?
         
         在搞一种自定义位置的
         */
    
    currentStation = menuStation;
    
    [self reloadLineView];
    
    
}
@end





@implementation FTFMiddleView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    [solidShapeLayer setStrokeColor:[[UIColor clearColor] CGColor]];
    solidShapeLayer.lineWidth = 1.0f;
    if (self.state == FTFArrowStateDown) {
        CGPathMoveToPoint(solidShapePath, NULL,0,0);
        CGPathAddLineToPoint(solidShapePath, NULL,self.frame.size.width / 2,self.frame.size.height);
        CGPathAddLineToPoint(solidShapePath, NULL,self.frame.size.width,0);
    }
    if (self.state == FTFArrowStateUp) {
        CGPathMoveToPoint(solidShapePath, NULL,0,self.frame.size.height);
        CGPathAddLineToPoint(solidShapePath, NULL,self.frame.size.width / 2,0);
        CGPathAddLineToPoint(solidShapePath, NULL,self.frame.size.width,self.frame.size.height);
    }
    if (self.state == FTFArrowStateRight) {
        CGPathMoveToPoint(solidShapePath, NULL,0,0);
        CGPathAddLineToPoint(solidShapePath, NULL,self.frame.size.width,self.frame.size.height / 2);
        CGPathAddLineToPoint(solidShapePath, NULL,0,self.frame.size.height);
    }
    if (self.state == FTFArrowStateLeft) {
        CGPathMoveToPoint(solidShapePath, NULL,self.frame.size.width,0);
        CGPathAddLineToPoint(solidShapePath, NULL,0,self.frame.size.height / 2);
        CGPathAddLineToPoint(solidShapePath, NULL,self.frame.size.width,self.frame.size.height);
    }
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.layer addSublayer:solidShapeLayer];
}


@end


@implementation FTFMenusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size cellStyle:(FTFMenusType)cellStyle{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeight = size.height;
        CGFloat cellWidth = size.width;
        
        /*
         样式要在这里传入
         */
        
        //下划线
        CGFloat lineX = cellWidth *0.06;
        self.lineLabel = [[UILabel alloc]init];
        self.lineLabel.frame = CGRectMake(lineX, cellHeight - 1, cellWidth - lineX *2, 0.77);
        self.lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineLabel];

        //图片
        CGFloat titleX = 0;
        CGFloat imageX = cellWidth *0.015;
        NSTextAlignment aligment = NSTextAlignmentCenter;
        if (cellStyle == FTFMenusImage) {
            CGFloat imageHeight = cellHeight *0.62;
            self.logoImageView = [[UIImageView alloc]init];
            self.logoImageView.frame = CGRectMake(imageX, (cellHeight - imageHeight) / 2, imageHeight, imageHeight);
//            self.logoImageView.image = [UIImage imageNamed:@"A1"];
            [self.contentView addSubview:self.logoImageView];
            
            titleX = imageX *2.5 + imageHeight;
            aligment = NSTextAlignmentLeft;
        }
        
        //文本
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = CGRectMake(titleX, 0, cellWidth - titleX - imageX, cellHeight);
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = aligment;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        
        
    }
    return self;
}
@end
