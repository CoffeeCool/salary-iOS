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
#import "FMDB.h"
#import "JVFloatLabeledTextFieldViewController3.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "CBStoreHouseTransition.h"
const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface JVFloatLabeledTextFieldViewController3 ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong)JVFloatLabeledTextView *usage;
@property (nonatomic, strong)JVFloatLabeledTextView *text5;
@property (nonatomic, strong)JVFloatLabeledTextField *titleField;
@property (nonatomic, strong)JVFloatLabeledTextField *priceField;
@property (nonatomic, strong)JVFloatLabeledTextView *descriptionField;
@property (nonatomic, strong)UIButton *pay;
@property (nonatomic, strong) CBStoreHouseTransitionAnimator *animator;
@property (nonatomic, strong) CBStoreHouseTransitionInteractiveTransition *interactiveTransition;
@end

@implementation JVFloatLabeledTextFieldViewController3




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"详情", @"");
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

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
    self.interactiveTransition = [[CBStoreHouseTransitionInteractiveTransition alloc] init];
    [self.interactiveTransition attachToViewController:self];
}
- (void)cancel:(id)sender {
    self.interactiveTransition = nil;
    [self dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"cancel");
}

- (void)save:(id)sender {
    [_titleField resignFirstResponder];
    [_priceField resignFirstResponder];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger intstr = [_priceField.text integerValue];
    
    [userDefault setInteger:intstr forKey:@"myMoney"];
    [userDefault setObject:_titleField.text forKey:@"myCEO"];
    [self dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"save");
}
-(void)hideKeyboard{
    [_titleField resignFirstResponder];
    [_priceField resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationItem];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];

    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
#endif
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIColor *floatingLabelColor = [UIColor lightGrayColor];
    
    _titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"CEO", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _titleField.floatingLabelTextColor = [UIColor orangeColor];
    _titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_titleField];
    _titleField.translatesAutoresizingMaskIntoConstraints = NO;
    _titleField.keepBaseline = 1;
    _titleField.text = [userDefaults objectForKey:@"myCEO"];
    _titleField.returnKeyType = UIReturnKeyNext;
    //_titleField.userInteractionEnabled = NO;

    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;

    _priceField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _priceField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"总资产", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _priceField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _priceField.floatingLabelTextColor = [UIColor orangeColor];
    [self.view addSubview:_priceField];
    NSString *money = [NSString stringWithFormat:@"%ld", (long)[userDefaults integerForKey:@"myMoney"]];
    _priceField.keyboardType = UIKeyboardTypeNumberPad;
    _priceField.text = money;
    _priceField.translatesAutoresizingMaskIntoConstraints = NO;


    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    
    JVFloatLabeledTextField *locationField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    locationField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    locationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"人数", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    locationField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    locationField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:locationField];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    int numOfPeople = 0;
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    FMResultSet *s = [db executeQuery:@"SELECT COUNT(*) FROM PersonList"];
    if ([s next]) {
        numOfPeople = [s intForColumnIndex:0];
    }
    [db close];
    NSString *employeesNum = [NSString stringWithFormat:@"%d人", numOfPeople];
    locationField.text = employeesNum;
    locationField.userInteractionEnabled = NO;
    locationField.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UIView *div3 = [UIView new];
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    div3.translatesAutoresizingMaskIntoConstraints = NO;

    _descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectZero];
    _descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _descriptionField.placeholder = NSLocalizedString(@"本月需支付薪资", @"");
    _descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    _descriptionField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:_descriptionField];
    NSString *myAllPay = [NSString stringWithFormat:@"%ld", (long)[userDefaults integerForKey:@"myAllPay"]];
    _descriptionField.text = myAllPay;
    _descriptionField.userInteractionEnabled = NO;
    _descriptionField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div4 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*3, self.view.frame.size.width, 0.5)];
    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div4];
    div4.translatesAutoresizingMaskIntoConstraints = NO;
    
    _usage = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*3+1, self.view.frame.size.width, kJVFieldHeight)];
    _usage.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _usage.placeholder = NSLocalizedString(@"本月已支付薪资", @"");
    _usage.placeholderTextColor = [UIColor darkGrayColor];
    _usage.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _usage.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:_usage];
    NSString *myHavePayed = [NSString stringWithFormat:@"%ld", (long)[userDefaults integerForKey:@"myHavePayed"]];
    _usage.text = myHavePayed;
    _usage.userInteractionEnabled = NO;
    _usage.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div5 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*4, self.view.frame.size.width, 0.5)];
    div5.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div5];
    div5.translatesAutoresizingMaskIntoConstraints = NO;
    
    _text5 = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*4+1, self.view.frame.size.width, kJVFieldHeight)];
    _text5.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _text5.placeholder = NSLocalizedString(@"本月还需支付薪资", @"");
    _text5.placeholderTextColor = [UIColor darkGrayColor];
    _text5.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _text5.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:_text5];
    NSString *myWillPay = [NSString stringWithFormat:@"%ld", (long)[userDefaults integerForKey:@"myAllPay"] - [userDefaults integerForKey:@"myHavePayed"]];
    _text5.text = myWillPay;
    _text5.translatesAutoresizingMaskIntoConstraints = NO;
    _text5.userInteractionEnabled = NO;
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_titleField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_titleField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_priceField]-(xMargin)-[div2(1)]-(xMargin)-[locationField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_priceField, div2, locationField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div3)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_descriptionField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_descriptionField)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleField(>=minHeight)][div1(1)][_priceField(>=minHeight)][div3(1)][_descriptionField]|" options:0 metrics:@{@"minHeight": @(kJVFieldHeight)} views:NSDictionaryOfVariableBindings(_titleField, div1, _priceField, div3, _descriptionField)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:locationField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    UILabel *yuan1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    yuan1.font = [UIFont boldSystemFontOfSize:16.0];
    yuan1.textAlignment = NSTextAlignmentCenter;
    yuan1.center = CGPointMake(250, 75);
    yuan1.text = @"元";
    [self.view addSubview:yuan1];
    
    UILabel *yuan2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    yuan2.font = [UIFont boldSystemFontOfSize:16.0];
    yuan2.textAlignment = NSTextAlignmentCenter;
    yuan2.center = CGPointMake(300, 115);
    yuan2.text = @"元";
    [self.view addSubview:yuan2];
    
    UILabel *yuan3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    yuan3.font = [UIFont boldSystemFontOfSize:16.0];
    yuan3.textAlignment = NSTextAlignmentCenter;
    yuan3.center = CGPointMake(300, 155);
    yuan3.text = @"元";
    [self.view addSubview:yuan3];
    
    UILabel *yuan4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    yuan4.font = [UIFont boldSystemFontOfSize:16.0];
    yuan4.textAlignment = NSTextAlignmentCenter;
    yuan4.center = CGPointMake(300, 195);
    yuan4.text = @"元";
    [self.view addSubview:yuan4];
    
    //[titleField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
