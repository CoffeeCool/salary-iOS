//
//  JVFloatLabeledTextFieldViewController.m
//  JVFloatLabeledTextField
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013-2015 Jared Verdi
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "JVFloatLabeledTextFieldViewController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "CBStoreHouseTransition.h"
#import "FMDB.h"
const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface JVFloatLabeledTextFieldViewController ()<UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong)JVFloatLabeledTextView *usage;
@property (nonatomic, strong)UIButton *pay;
@property (nonatomic, strong)UIButton *deleteDep;
@property (nonatomic, strong) CBStoreHouseTransitionAnimator *animator;
@property  NSString *Name;
@property (nonatomic, strong) CBStoreHouseTransitionInteractiveTransition *interactiveTransition;
@property (nonatomic)NSInteger index;
@property (nonatomic)NSInteger allPay;
@property BOOL isPayMoney;
@property (nonatomic, strong) JVFloatLabeledTextField *titleField;
@property (nonatomic, strong) JVFloatLabeledTextField *priceField;
@property (nonatomic, strong) JVFloatLabeledTextField *locationField;
@property (nonatomic, strong) JVFloatLabeledTextView *descriptionField;
@end

@implementation JVFloatLabeledTextFieldViewController

- (instancetype)initForNew:(NSInteger)index title:(NSString*)name {
    _index = index;
    _Name = name;
    
    
    self = [super init];
    return self;
}

- (instancetype)initForNew:(NSInteger)index {
    _index = index;
    self = [super init];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (_index == -1) {
            self.title = NSLocalizedString(@"新增部门", @"");
        }else {
            self.title = NSLocalizedString(_Name, @"");
        }
        
    }
    return self;
}

- (void)setupNavigationItem {
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    [cancel setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = cancel;
    [self.navigationController.navigationBar setTranslucent:NO];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = save;
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"cancel");
}

- (void)save:(id)sender {
    [_titleField resignFirstResponder];
    [_priceField resignFirstResponder];
    [_descriptionField resignFirstResponder];
    [_locationField resignFirstResponder];
    [_usage resignFirstResponder];
    if ([_titleField.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_priceField.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_descriptionField.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_usage.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }

    if (_index == -1) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        NSLog(@"name:%@ , manager:%@, award:%@, expand:%@", _priceField.text, _titleField.text, [NSNumber numberWithInt:[_descriptionField.text intValue]],[NSNumber numberWithInt:[_usage.text intValue]]);
        [db executeUpdate:@"INSERT INTO DepartmentList (D_Name ,Manager, D_Award, D_Expand) VALUES (?,?,?,?)",_priceField.text,_titleField.text,[NSNumber numberWithInt:[_descriptionField.text intValue]],[NSNumber numberWithInt:[_usage.text intValue]]];
        [db close];
    }else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        [db executeUpdate:@"UPDATE DepartmentList SET Manager = ?, D_Award = ?, D_Expand = ? WHERE D_Name = ?",_titleField.text,[NSNumber numberWithInt:[_descriptionField.text intValue]], [NSNumber numberWithInt:[_usage.text intValue]], _Name];
        [db close];
    }
    NSLog(@"save");
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)hideKeyboard:(id)sender{
    [_titleField resignFirstResponder];
    [_priceField resignFirstResponder];
    [_descriptionField resignFirstResponder];
    [_locationField resignFirstResponder];
    [_usage resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationItem];
    
    _isPayMoney = NO;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];

    
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
#endif
    
    UIColor *floatingLabelColor = [UIColor orangeColor];
    
    _titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"部门主管", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _titleField.floatingLabelTextColor = floatingLabelColor;
    _titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _titleField.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:_titleField];
    _titleField.delegate = self;
    _titleField.translatesAutoresizingMaskIntoConstraints = NO;
    _titleField.keepBaseline = 1;
    //titleField.text = @"蔡戈辉";
    //titleField.userInteractionEnabled = NO;

    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;

    _priceField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _priceField.delegate = self;
    _priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"薪资支出", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _priceField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _priceField.floatingLabelTextColor = [UIColor darkGrayColor];
    [self.view addSubview:_priceField];
    _priceField.userInteractionEnabled = NO;
    if (_index == -1) {
        
        _priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"部门名称", @"")
                                                                            attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
        _priceField.floatingLabelTextColor = floatingLabelColor;
        _priceField.userInteractionEnabled = YES;
    }else {
        _priceField.keyboardType = UIKeyboardTypeNumberPad;
    }
    //_priceField.text = @"￥10000";
    
    _priceField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    
    _locationField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _locationField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _locationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"人数", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];

    _locationField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _locationField.floatingLabelTextColor = [UIColor darkGrayColor];
    [self.view addSubview:_locationField];
    //_locationField.text = @"14";
    _locationField.userInteractionEnabled = NO;
    _locationField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div3 = [UIView new];
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    div3.translatesAutoresizingMaskIntoConstraints = NO;

    _descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectZero];
    _descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _descriptionField.placeholder = NSLocalizedString(@"部门奖金", @"");
    _descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    _descriptionField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:_descriptionField];
    //descriptionField.text = @"2000";
    _descriptionField.keyboardType = UIKeyboardTypeNumberPad;
    _descriptionField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div4 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*3, self.view.frame.size.width, 0.5)];
    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div4];
    div4.translatesAutoresizingMaskIntoConstraints = NO;
    
    _usage = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*3+1, self.view.frame.size.width, kJVFieldHeight)];
    _usage.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _usage.placeholder = NSLocalizedString(@"部门支出", @"");

    _usage.placeholderTextColor = [UIColor darkGrayColor];
    _usage.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _usage.floatingLabelTextColor = floatingLabelColor;
    _usage.keyboardType = UIKeyboardTypeNumberPad;

    [self.view addSubview:_usage];
    //_usage.text = @"3000";
    _usage.translatesAutoresizingMaskIntoConstraints = NO;
    
    _pay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*4/5, 30)];
    _pay.layer.cornerRadius = self.view.frame.size.width*4/5 * 0.05;
    _pay.backgroundColor = [UIColor colorWithRed:106/255.0 green:189/255.0 blue:120/255.0 alpha:1];
    [_pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_pay.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //[_pay setTitle:@"确认支付:￥15000" forState:UIControlStateNormal];
    [_pay setCenter:CGPointMake(self.view.frame.size.width/2, kJVFieldHeight*5)];
    [_pay addTarget:self action:@selector(payMoney) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pay];
    
    
    _deleteDep = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*4/5, 30)];
    _deleteDep.layer.cornerRadius = self.view.frame.size.width*4/5 * 0.05;
    _deleteDep.backgroundColor = [UIColor colorWithRed:255/255.0 green:90/255.0 blue:95/255.0 alpha:1];
    [_deleteDep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteDep.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //[_pay setTitle:@"确认支付:￥15000" forState:UIControlStateNormal];
    [_deleteDep setCenter:CGPointMake(self.view.frame.size.width/2, kJVFieldHeight*6)];
    [_deleteDep addTarget:self action:@selector(deleteName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteDep];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_titleField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_titleField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_priceField]-(xMargin)-[div2(1)]-(xMargin)-[_locationField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_priceField, div2, _locationField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div3)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_descriptionField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_descriptionField)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleField(>=minHeight)][div1(1)][_priceField(>=minHeight)][div3(1)][_descriptionField]|" options:0 metrics:@{@"minHeight": @(kJVFieldHeight)} views:NSDictionaryOfVariableBindings(_titleField, div1, _priceField, div3, _descriptionField)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_locationField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    

}

- (void)viewWillAppear:(BOOL)animated {
    if (_index == -1) {
        [_titleField becomeFirstResponder];
        
        _pay.hidden = YES;
        _deleteDep.hidden = YES;
    }else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
        
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        NSString *name;
        NSString *manager;
        int award = 0;
        int expand = 0;
        FMResultSet *s = [db executeQuery:@"SELECT * FROM DepartmentList"];
        int i = 0;
        while ([s next]) {
            if (i == _index) {
                name = [s stringForColumn:@"D_Name"];
                manager = [s stringForColumn:@"Manager"];
                award = [s intForColumn:@"D_Award"];
                expand = [s intForColumn:@"D_Expand"];
                break;
            }
            i++;
        }
        [db close];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        
        FMResultSet *s3 = [db executeQuery:@"SELECT COUNT(*) FROM PersonList WHERE Department = ?", name];
        int numOfP = 0;
        i = 0;
        if ([s3 next]) {
            numOfP = [s3 intForColumnIndex:0];
        }
        [db close];
        
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        FMResultSet *s2 = [db executeQuery:@"SELECT * FROM PersonList WHERE Department = ?", name];
        i = 0;
        int allToPay = 0;
        while ([s2 next]) {
            int basePay = [s2 intForColumn:@"BasePay"];
            int bonus = [s2 intForColumn:@"Bonus"];
            int award = [s2 intForColumn:@"Award"];
            int insurance = [s2 intForColumn:@"Insurance"];
            int fund = [s2 intForColumn:@"Fund"];
            int pay = basePay + bonus + award - insurance - fund;
            NSLog(@"%d::%d", i, pay);
            allToPay = allToPay + pay;
            i++;
        }
        
        [db close];
        
        [_titleField setText:manager];
        [_priceField setText:[NSString stringWithFormat:@"%d", allToPay]];
        [_locationField setText:[NSString stringWithFormat:@"%d", numOfP]];
        [_descriptionField setText:[NSString stringWithFormat:@"%d", award]];
        [_usage setText:[NSString stringWithFormat:@"%d", expand]];
        
        allToPay = allToPay + award - expand;
        _allPay = allToPay;
        [_pay setTitle:[NSString stringWithFormat:@"确认支付:￥%d", allToPay] forState:UIControlStateNormal];
        [_deleteDep setTitle:@"删除部门" forState:UIControlStateNormal];
    }
}

- (void)payMoney {
    _isPayMoney = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认支付" message:[NSString stringWithFormat:@"确认支付￥%ld", (long)_allPay] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (_isPayMoney) {
            _isPayMoney = NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:[defaults integerForKey:@"myMoney"] - _allPay forKey:@"myMoney"];
            
        }else {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory = [paths objectAtIndex:0];
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
            FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
            if (![db open]) {
                NSLog(@"Could not open db.");
            }
            [db executeUpdate:@"DELETE FROM DepartmentList WHERE D_Name = ?", _Name];
            [db close];
            [self dismissViewControllerAnimated:YES completion:^{}];
        }

    }
    NSLog(@"delete");
}

- (void)deleteName {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除" message:@"删除后无法恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_titleField isFirstResponder]) {
        if (_index == -1) {
            [_priceField becomeFirstResponder];
        }else {
            [_descriptionField becomeFirstResponder];
        }
    }else if ([_priceField isFirstResponder]) {
        [_descriptionField becomeFirstResponder];
    }
    
    return YES;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:
            //we don't need interactive transition for push
            self.interactiveTransition = nil;
            self.animator.type = AnimationTypePush;
            return self.animator;
        case UINavigationControllerOperationPop:
            self.animator.type = AnimationTypePop;
            return self.animator;
        default:
            return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactiveTransition;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
