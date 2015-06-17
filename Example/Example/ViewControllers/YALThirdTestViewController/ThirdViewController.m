//
//  ThirdViewController.m
//  Example
//
//  Created by Coffee on 15/6/15.
//  Copyright (c) 2015年 Yalantis. All rights reserved.
//

#import "ThirdViewController.h"
#import "SearchTextField.h"
#import "JVFloatLabeledTextFieldViewController2.h"
#import "FMDB.h"
@interface ThirdViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet SearchTextField *search;
@property (nonatomic) NSInteger numOfRows;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
    _search.layer.cornerRadius= _search.frame.size.height/2;
    _search.layer.masksToBounds=YES;
    _search.layer.borderColor=[[UIColor groupTableViewBackgroundColor]CGColor];
    _search.layer.borderWidth= 1.0f;
    [_search setTintColor:[UIColor groupTableViewBackgroundColor]];
    [_search setValue:[UIColor groupTableViewBackgroundColor] forKeyPath:@"_placeholderLabel.textColor"];
    _search.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    _search.leftViewMode = UITextFieldViewModeAlways;
    _search.clearButtonMode = UITextFieldViewModeAlways;
    _search.returnKeyType = UIReturnKeySearch;
    _search.delegate = self;
    
    
    _tableVIew.backgroundColor = [UIColor clearColor];
    _tableVIew.showsVerticalScrollIndicator = NO;
    _tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    [backgroundImage setImage:[UIImage imageNamed:@"mb_2"]];
    [self.view insertSubview:backgroundImage atIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    if (![_search.text  isEqual: @""]) {
        NSString *str = [NSString stringWithFormat:@"SELECT COUNT(*) FROM PersonList WHERE Name LIKE '%@'", _search.text];
        FMResultSet *s = [db executeQuery:str];
        if ([s next]) {
            _numOfRows = [s intForColumnIndex:0];
            NSLog(@"%ld", (long)_numOfRows);
        }
    }else {
        FMResultSet *s = [db executeQuery:@"SELECT COUNT(*) FROM PersonList"];
        if ([s next]) {
            _numOfRows = [s intForColumnIndex:0];
            NSLog(@"%ld", (long)_numOfRows);
        }
    }
    [db close];

    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    NSLog(@"%@", _search.text);

    if (![_search.text  isEqual: @""]) {
        NSString *str = [NSString stringWithFormat:@"SELECT COUNT(*) FROM PersonList WHERE Name LIKE '%@'", _search.text];
        FMResultSet *s = [db executeQuery:str];
        if ([s next]) {
            _numOfRows = [s intForColumnIndex:0];
            NSLog(@"%ld", (long)_numOfRows);
        }
    }
    else {
        FMResultSet *s = [db executeQuery:@"SELECT COUNT(*) FROM PersonList"];
        if ([s next]) {
            _numOfRows = [s intForColumnIndex:0];
            NSLog(@"%ld", (long)_numOfRows);
        }
    }
    if ([_search.text isEqual:@"二货"] || [_search.text isEqual:@"逗比"] ){
        _numOfRows = 1;
        
    }
    [db close];
    [self.tableVIew reloadData];
    
    [self.search resignFirstResponder];
    
    return YES;
}

-(void)hideKeyboard:(id)sender{
    [_search resignFirstResponder];

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)extraRightItemDidPressed {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[JVFloatLabeledTextFieldViewController2 alloc] initForNew:-1]];
    [self presentViewController:nvc animated:YES completion:^{}];
    //NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}


- (void)viewWillAppear:(BOOL)animated {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    if (![_search.text  isEqual: @""]) {
        NSString *str = [NSString stringWithFormat:@"SELECT COUNT(*) FROM PersonList WHERE Name LIKE '%@'", _search.text];
        FMResultSet *s = [db executeQuery:str];
        if ([s next]) {
            _numOfRows = [s intForColumnIndex:0];
            NSLog(@"%ld", (long)_numOfRows);
        }
    }
    else {
        FMResultSet *s = [db executeQuery:@"SELECT COUNT(*) FROM PersonList"];
        if ([s next]) {
            _numOfRows = [s intForColumnIndex:0];
            NSLog(@"%ld", (long)_numOfRows);
        }
    }
    if ([_search.text isEqual:@"二货"] || [_search.text isEqual:@"逗比"]) {
        _numOfRows = 1;
    }
    [db close];
    [self.tableVIew reloadData];
    NSLog(@"viewWillAppear");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _numOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"person"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius = cell.frame.size.height/6;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:1];
    int j = arc4random()%5;
    NSString *str = [NSString stringWithFormat:@"img_0%d", j];
    [imageView setImage:[UIImage imageNamed:str]];
    
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:2];
    //[name setText:@"蔡戈辉"];
    //[name setTextColor:[UIColor darkGrayColor]];
    UILabel *payLabel = (UILabel*)[cell viewWithTag:3];
    //[pay setText:@"本月应支付: ￥12000"];
    [payLabel setTextColor:[UIColor lightGrayColor]];
    UILabel *position = (UILabel*)[cell viewWithTag:4];
    //[position setText:@"市场部 主管"];
    [position setTextColor:[UIColor lightGrayColor]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    FMResultSet *s;
    if (![_search.text isEqual:@""]) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM PersonList WHERE Name LIKE '%@'", _search.text];
        s = [db executeQuery:str];
    }
    else {
        s = [db executeQuery:@"SELECT * FROM PersonList"];
    }
    if ([_search.text isEqual:@"二货"] || [_search.text isEqual:@"逗比"]){
        NSString *str = @"SELECT * FROM PersonList WHERE Name LIKE '黄军锋'";
        s = [db executeQuery:str];
        
    }
    
    int i = 0;
    while ([s next]) {
        if (i == indexPath.section) {
            NSString *name = [s stringForColumn:@"Name"];
            [nameLabel setText:name];
            NSString *department = [s stringForColumn:@"Department"];
            NSString *role = [s stringForColumn:@"Role"];
            NSString *identity = [NSString stringWithFormat:@"%@ %@", department, role];
            [position setText:identity];
            int basePay = [s intForColumn:@"BasePay"];
            int bonus = [s intForColumn:@"Bonus"];
            int award = [s intForColumn:@"Award"];
            int insurance = [s intForColumn:@"Insurance"];
            int fund = [s intForColumn:@"Fund"];
            int pay = basePay + bonus + award - insurance - fund;
            NSString *paystr = [NSString stringWithFormat:@"应付工资：￥%ld", (long)pay];
            
            [payLabel setText:paystr];
        }
        i++;
    }
    [db close];
    
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"aa");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    FMResultSet *s;
    if (![_search.text isEqual:@""]) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM PersonList WHERE Name LIKE '%@'", _search.text];
        s = [db executeQuery:str];
    }else {
        s = [db executeQuery:@"SELECT * FROM PersonList"];
    }
    
    int i = 0;
    while ([s next]) {
        if (i == indexPath.section) {
            NSString *name = [s stringForColumn:@"Name"];
            NSString *department = [s stringForColumn:@"Department"];
            NSString *role = [s stringForColumn:@"Role"];
            int age = [s intForColumn:@"Age"];
            int basePay = [s intForColumn:@"BasePay"];
            int bonus = [s intForColumn:@"Bonus"];
            int award = [s intForColumn:@"Award"];
            int insurance = [s intForColumn:@"Insurance"];
            int fund = [s intForColumn:@"Fund"];
            int pay = basePay + bonus + award - insurance - fund;
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[JVFloatLabeledTextFieldViewController2 alloc] initForWhat:indexPath.section name:name department:department role:role age:age basePay:basePay bonus:bonus award:award insurance:insurance fund:fund payNum:pay]];
            nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nvc animated:YES completion:^{}];
            break;
        }
        i++;
    }
    [db close];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
