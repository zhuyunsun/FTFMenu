//
//  ViewController.m
//  FTFMenu
//
//  Created by 朱运 on 2021/12/1.
//

#import "ViewController.h"
#import "AnViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTableView;
    NSArray *dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单栏";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    dataSource = @[@"带三角形的菜单栏"];
    
    myTableView = [[UITableView alloc]init];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height *0.75);
    [self.view addSubview:myTableView];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row;
    BaseStyleController *baseVC = [[BaseStyleController alloc]init];
    if (index == 0) {
        baseVC = [[AnViewController alloc]init];
    }
    [self.navigationController pushViewController:baseVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    if (dataSource.count > indexPath.row) {
        cell.textLabel.text = dataSource[indexPath.row];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height / 11;
}
@end
