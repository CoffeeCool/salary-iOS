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

#import "JVFloatLabeledTextFieldViewController2.h"
#import "FMDB.h"
const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;
const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;
@interface JVFloatLabeledTextFieldViewController2 ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate, UITextViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    NSString *name;
    NSString *department;
    NSString *role;
    int age;
    int basePay;
    int bonus;
    int award;
    int insurance;
    int fund;
    int payNum;
        
}
@end

@implementation JVFloatLabeledTextFieldViewController2


- (instancetype)initForWhat:(NSInteger)index name:(NSString *)name_ department:(NSString*)department_ role:(NSString*)role_ age:(int)age_ basePay:(int)basePay_ bonus:(int)bonus_ award:(int)award_ insurance:(int)insurance_ fund:(int)fund_ payNum:(int)payNum_{
    _index = index;
    name = name_;
    department = department_;
    role = role_;
    age = age_;
    basePay = basePay_;
    bonus = bonus_;
    award = award_;
    insurance = insurance_;
    fund = fund_;
    payNum = payNum_;
    self = [super init];
    
    return self;
}
- (instancetype)initForNew:(NSInteger)index {
    self = [super init];
    _index = -1;
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (_index == -1) {
            self.title = NSLocalizedString(@"新增员工", @"");
        }else {
            self.title = NSLocalizedString(name, @"");
        }
        
    }
    return self;
}


-(void)hideKeyboard:(id)sender{
    [_titleField resignFirstResponder];
    [_priceField resignFirstResponder];
    [_descriptionField resignFirstResponder];
    [_locationField resignFirstResponder];
    [_usage resignFirstResponder];
    [_text5 resignFirstResponder];
    [_text6 resignFirstResponder];
    [_text7 resignFirstResponder];
    [_text8 resignFirstResponder];
    [_text9 resignFirstResponder];
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
    [_text5 resignFirstResponder];
    [_text6 resignFirstResponder];
    [_text7 resignFirstResponder];
    [_text8 resignFirstResponder];
    [_text9 resignFirstResponder];
    if ([_titleField.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_priceField.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_locationField.text  isEqual: @""]) {
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
    }else if ([_text5.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_text6.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_text7.text  isEqual: @""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"信息不完整" message:@"请核对并填写了全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else if ([_text8.text  isEqual: @""]) {
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
        [db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Department, Role, BasePay, Bonus, Award, Insurance, Fund) VALUES (?,?,?,?,?,?,?,?,?,?)",
         _titleField.text, [NSNumber numberWithInt:[_locationField.text intValue]], [NSNumber numberWithInt:0], _priceField.text, _descriptionField.text, [NSNumber numberWithInt:[_usage.text intValue]], [NSNumber numberWithInt:[_text5.text intValue]], [NSNumber numberWithInt:[_text6.text intValue]], [NSNumber numberWithInt:[_text7.text intValue]], [NSNumber numberWithInt:[_text8.text intValue]]];
        [db close];
    }else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        [db executeUpdate:@"UPDATE PersonList SET Name = ?, Age = ?, Sex = ?, Department = ?, Role = ?, BasePay = ?, Bonus = ?, Award = ?, Insurance = ?, Fund = ? WHERE Name = ?",
         _titleField.text, [NSNumber numberWithInt:[_locationField.text intValue]], [NSNumber numberWithInt:0], _priceField.text, _descriptionField.text, [NSNumber numberWithInt:[_usage.text intValue]], [NSNumber numberWithInt:[_text5.text intValue]], [NSNumber numberWithInt:[_text6.text intValue]], [NSNumber numberWithInt:[_text7.text intValue]], [NSNumber numberWithInt:[_text8.text intValue]], name];
        [db close];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"save");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        [db executeUpdate:@"DELETE FROM PersonList WHERE Name = ?", name];
        [db close];
        [self dismissViewControllerAnimated:YES completion:^{}];
        NSLog(@"delete");
    }
}

- (void)deleteName {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除" message:@"删除后无法恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboadWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIColor *floatingLabelColor = [UIColor lightGrayColor];
#pragma mark - 1
    
    _titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"姓名", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _titleField.floatingLabelTextColor = floatingLabelColor;
    _titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _titleField.returnKeyType = UIReturnKeyNext;
    _titleField.delegate = self;
    [self.view addSubview:_titleField];
    _titleField.translatesAutoresizingMaskIntoConstraints = NO;
    _titleField.keepBaseline = 1;
    
    //_titleField.text = @"蔡戈辉";

    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;

#pragma mark - 2
    
    _priceField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"部门", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _priceField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _priceField.floatingLabelTextColor = floatingLabelColor;
    _priceField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _priceField.returnKeyType = UIReturnKeyNext;
    _priceField.delegate = self;
    [self.view addSubview:_priceField];
    //_priceField.text = @"开发部";
    _priceField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;

#pragma mark - 3
    
    _locationField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    _locationField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _locationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"年龄", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _locationField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _locationField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:_locationField];
    //_locationField.text = @"19";
    _locationField.keyboardType = UIKeyboardTypeNumberPad;
    _locationField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div3 = [UIView new];
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    div3.translatesAutoresizingMaskIntoConstraints = NO;

#pragma mark - 4
    
    _descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectZero];
    _descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _descriptionField.placeholder = NSLocalizedString(@"职位", @"");
    _descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    _descriptionField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:_descriptionField];
    //_descriptionField.text = @"技术总监";
    _descriptionField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div4 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*3, self.view.frame.size.width, 0.5)];
    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div4];
    div4.translatesAutoresizingMaskIntoConstraints = NO;
    
#pragma mark - 5
    
    _usage = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*3+1, self.view.frame.size.width, kJVFieldHeight)];
    _usage.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _usage.placeholder = NSLocalizedString(@"基本工资", @"");
    _usage.placeholderTextColor = [UIColor darkGrayColor];
    _usage.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _usage.floatingLabelTextColor = floatingLabelColor;
    _usage.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_usage];
    //_usage.text = @"￥3000";
    _usage.translatesAutoresizingMaskIntoConstraints = NO;
    

    UIView *div5 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*4, self.view.frame.size.width, 0.5)];
    div5.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div5];
    div5.translatesAutoresizingMaskIntoConstraints = NO;

#pragma mark - 6
    
    _text5 = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*4+1, self.view.frame.size.width, kJVFieldHeight)];
    _text5.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _text5.placeholder = NSLocalizedString(@"福利补贴", @"");
    _text5.placeholderTextColor = [UIColor darkGrayColor];
    _text5.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _text5.floatingLabelTextColor = floatingLabelColor;
    _text5.delegate = self;
    [self.view addSubview:_text5];
    //_text5.text = @"￥1000";
    _text5.translatesAutoresizingMaskIntoConstraints = NO;
    _text5.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *div6 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*5, self.view.frame.size.width, 0.5)];
    div6.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div6];
    div6.translatesAutoresizingMaskIntoConstraints = NO;
    
#pragma mark - 7
    
    _text6 = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*5+1, self.view.frame.size.width, kJVFieldHeight)];
    _text6.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _text6.placeholder = NSLocalizedString(@"奖励工资", @"");
    _text6.placeholderTextColor = [UIColor darkGrayColor];
    _text6.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _text6.floatingLabelTextColor = floatingLabelColor;
    _text6.delegate = self;
    [self.view addSubview:_text6];
    //_text6.text = @"￥20000";
    _text6.translatesAutoresizingMaskIntoConstraints = NO;
    _text6.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *div7 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*6, self.view.frame.size.width, 0.5)];
    div7.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div7];
    div7.translatesAutoresizingMaskIntoConstraints = NO;

#pragma mark - 8
    _text7 = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*6+1, self.view.frame.size.width, kJVFieldHeight)];
    _text7.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _text7.placeholder = NSLocalizedString(@"失业保险", @"");
    _text7.placeholderTextColor = [UIColor darkGrayColor];
    _text7.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _text7.floatingLabelTextColor = floatingLabelColor;
    _text7.delegate = self;
    [self.view addSubview:_text7];
    //_text7.text = @"￥500";
    _text7.translatesAutoresizingMaskIntoConstraints = NO;
    _text7.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *div8 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*7, self.view.frame.size.width, 0.5)];
    div8.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div8];
    div8.translatesAutoresizingMaskIntoConstraints = NO;
    
#pragma mark - 9
    
    _text8 = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*7+1, self.view.frame.size.width, kJVFieldHeight)];
    _text8.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _text8.placeholder = NSLocalizedString(@"住房公基金", @"");
    _text8.placeholderTextColor = [UIColor darkGrayColor];
    _text8.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _text8.floatingLabelTextColor = floatingLabelColor;
    _text8.delegate = self;
    [self.view addSubview:_text8];
    //_text8.text = @"￥2000";
    _text8.translatesAutoresizingMaskIntoConstraints = NO;
    _text8.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *div9 = [[UIView alloc] initWithFrame:CGRectMake(0, kJVFieldHeight*8, self.view.frame.size.width, 0.5)];
    div9.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:div9];
    div9.translatesAutoresizingMaskIntoConstraints = NO;
    
#pragma mark - 10
    
    _text9 = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, kJVFieldHeight*8+1, self.view.frame.size.width, kJVFieldHeight)];
    _text9.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _text9.placeholder = NSLocalizedString(@"应发工资", @"");
    _text9.placeholderTextColor = [UIColor darkGrayColor];
    _text9.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _text9.floatingLabelTextColor = floatingLabelColor;
    _text9.delegate = self;
    [self.view addSubview:_text9];
    //_text9.text = @"￥21500";
    _text9.translatesAutoresizingMaskIntoConstraints = NO;
    _text9.keyboardType = UIKeyboardTypeNumberPad;
    _text9.userInteractionEnabled = NO;

#pragma mark - 11
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*4/5, 30)];
    _deleteButton.layer.cornerRadius = self.view.frame.size.width*4/5 * 0.05;
    _deleteButton.backgroundColor = [UIColor grayColor];
    [_deleteButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_deleteButton setTitle:@"删除员工" forState:UIControlStateNormal];
    [_deleteButton setCenter:CGPointMake(self.view.frame.size.width/2, kJVFieldHeight*10)];
    [_deleteButton addTarget:self action:@selector(deleteName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton];
    
    if (_index == -1) {
        _text9.hidden = YES;
        _deleteButton.hidden = YES;
    }else {
        _titleField.text = name;
        _priceField.text = department;
        _locationField.text = [NSString stringWithFormat:@"%d", age];
        _descriptionField.text = role;
        _usage.text = [NSString stringWithFormat:@"%d", basePay];
        _text5.text = [NSString stringWithFormat:@"%d", bonus];
        _text6.text = [NSString stringWithFormat:@"%d", award];
        _text7.text = [NSString stringWithFormat:@"%d", insurance];
        _text8.text = [NSString stringWithFormat:@"%d", fund];
        _text9.text = [NSString stringWithFormat:@"%d", payNum];
    
    }
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_titleField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_titleField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_priceField]-(xMargin)-[div2(1)]-(xMargin)-[_locationField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_priceField, div2, _locationField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div3)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[_descriptionField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(_descriptionField)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleField(>=minHeight)][div1(1)][_priceField(>=minHeight)][div3(1)][_descriptionField]|" options:0 metrics:@{@"minHeight": @(kJVFieldHeight)} views:NSDictionaryOfVariableBindings(_titleField, div1, _priceField, div3, _descriptionField)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_locationField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    if (_index == -1) {
        [_titleField becomeFirstResponder];
    }
    
}
-(void) keyboadWillShow:(NSNotification *)note{
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
    if ([_text5 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text6 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text6 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text7 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text8 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text9 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }
    [UIView commitAnimations];//开始动画效果
    
}
//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 64);
    [UIView commitAnimations];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
    if ([_text5 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text6 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text6 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text7 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text8 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }else if([_text9 isFirstResponder]) {
        self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 60);
    }
    [UIView commitAnimations];//开始动画效果
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 64);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _titleField) {
        [_priceField becomeFirstResponder];
    }else if(textField == _priceField) {
        [_locationField becomeFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
