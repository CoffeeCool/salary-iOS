// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFourthTestViewController.h"
#import "JVFloatLabeledTextFieldViewController3.h"
#import "RKCardView.h"
#import "FMDB.h"
#define debug 1

@interface YALFourthTestViewController()
@property RKCardView* cardView;
@end

@implementation YALFourthTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    [backgroundImage setImage:[UIImage imageNamed:@"mb_3"]];
    [self.view insertSubview:backgroundImage atIndex:0];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width + 1, scrollView.frame.size.height +1 )];
    [self.view addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    _cardView= [[
                 RKCardView alloc]initWithFrame:CGRectMake(0, 0, 260, self.view.frame.size.height - 150)];
    _cardView.center = CGPointMake(self.view.center.x, self.view.center.y - 30);
    _cardView.coverImageView.image = [UIImage imageNamed:@"back2"];
    _cardView.profileImageView.image = [UIImage imageNamed:@"cHead"];
    NSString *myCompany = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"myCompany"]];
    _cardView.titleLabel.text = myCompany;
    _cardView.introduce.text = @"这里没有猴子，只有用双手成就你的梦想的ACER！";


    NSString *myCEO = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"myCEO"]];
    _cardView.managerLabel.text = myCEO;
    [_cardView.detail addTarget:self action:@selector(popupDetail) forControlEvents:UIControlEventTouchUpInside];
    //[cardView addBlur]; // comment this out if you don't want blur
    [_cardView addShadow]; // comment this out if you don't want a shadow
    [scrollView addSubview:_cardView];

    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated {
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

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *money = [NSString stringWithFormat:@"￥%ld", (long)[userDefaults integerForKey:@"myMoney"]];
    _cardView.salaryNum.text = money;
    NSString *employeesNum = [NSString stringWithFormat:@"%d人", numOfPeople];
    _cardView.memberNum.text = employeesNum;
}
- (void)popupDetail {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[JVFloatLabeledTextFieldViewController3 alloc] init]];
    [self presentViewController:nvc animated:YES completion:^{}];
}

#pragma mark - YALTabBarInteracting

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)tabBarViewWillCollapse {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewWillExpand {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewDidCollapsed {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

- (void)tabBarViewDidExpanded {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}


@end
