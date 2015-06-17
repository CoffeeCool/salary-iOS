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
const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface JVFloatLabeledTextFieldViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong)JVFloatLabeledTextView *usage;
@property (nonatomic, strong)UIButton *pay;
@property (nonatomic, strong) CBStoreHouseTransitionAnimator *animator;
@property (nonatomic, strong) CBStoreHouseTransitionInteractiveTransition *interactiveTransition;
@end

@implementation JVFloatLabeledTextFieldViewController

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
    NSLog(@"save");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationItem];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
#endif
    
    UIColor *floatingLabelColor = [UIColor lightGrayColor];
    
    JVFloatLabeledTextField *titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"部门主管", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    titleField.floatingLabelTextColor = floatingLabelColor;
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:titleField];
    titleField.translatesAutoresizingMaskIntoConstraints = NO;
    titleField.keepBaseline = 1;
    titleField.text = @"蔡戈辉";
    titleField.userInteractionEnabled = NO;

    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;

    JVFloatLabeledTextField *priceField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"薪资支出", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    priceField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    priceField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:priceField];
    priceField.text = @"￥10000";
    priceField.userInteractionEnabled = NO;
    priceField.translatesAutoresizingMaskIntoConstraints = NO;

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
    locationField.text = @"14";
    locationField.userInteractionEnabled = NO;
    locationField.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div3 = [UIView new];
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    div3.translatesAutoresizingMaskIntoConstraints = NO;

    JVFloatLabeledTextView *descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectZero];
    descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    descriptionField.placeholder = NSLocalizedString(@"部门奖金", @"");
    descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    descriptionField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:descriptionField];
    descriptionField.text = @"￥2000";
    descriptionField.userInteractionEnabled = NO;
    descriptionField.translatesAutoresizingMaskIntoConstraints = NO;

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
    [self.view addSubview:_usage];
    _usage.text = @"￥3000";
    _usage.userInteractionEnabled = NO;
    _usage.translatesAutoresizingMaskIntoConstraints = NO;
    
    _pay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*4/5, 30)];
    _pay.layer.cornerRadius = self.view.frame.size.width*4/5 * 0.05;
    _pay.backgroundColor = [UIColor grayColor];
    [_pay.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_pay setTitle:@"确认支付:￥15000" forState:UIControlStateNormal];
    [_pay setCenter:CGPointMake(self.view.frame.size.width/2, kJVFieldHeight*5)];
    [self.view addSubview:_pay];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[titleField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(titleField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[priceField]-(xMargin)-[div2(1)]-(xMargin)-[locationField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(priceField, div2, locationField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div3)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[descriptionField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(descriptionField)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleField(>=minHeight)][div1(1)][priceField(>=minHeight)][div3(1)][descriptionField]|" options:0 metrics:@{@"minHeight": @(kJVFieldHeight)} views:NSDictionaryOfVariableBindings(titleField, div1, priceField, div3, descriptionField)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:locationField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    [titleField becomeFirstResponder];
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
