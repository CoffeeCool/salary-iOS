// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "AppDelegate.h"

//model
#import "YALTabBarItem.h"

//controller
#import "YALFoldingTabBarController.h"

//helpers
#import "YALAnimatingTabBarConstants.h"

#import "FMDB.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupYALTabBarController];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"myCompany"]) {
        [userDefaults setObject:@"我的公司" forKey:@"myCompany"];
    }
    if (![userDefaults objectForKey:@"myCEO"]) {
        [userDefaults setObject:@"蔡戈辉" forKey:@"myCEO"];
    }
    if (![userDefaults objectForKey:@"myMoney"]) {
        [userDefaults setInteger:0 forKey:@"myMoney"];
    }
    if (![userDefaults objectForKey:@"myAllPay"]) {
        [userDefaults setInteger:0 forKey:@"myAllPay"];
    }
    if (![userDefaults objectForKey:@"myHavePayed"]) {
        [userDefaults setInteger:0 forKey:@"myHavePayed"];
    }
    if (![userDefaults objectForKey:@"myDepartmentNum"]) {
        [userDefaults setInteger:0 forKey:@"myDepartmentNum"];
    }
    if (![userDefaults objectForKey:@"myEmployeesNum"]) {
        [userDefaults setInteger:0 forKey:@"myEmployeesNum"];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    [db executeUpdate:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Department text, Role text, BasePay integer, Bonus integer, Award integer, Insurance integer, Fund integer)"];
    [db close];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    [db executeUpdate:@"CREATE TABLE DepartmentList (D_Name text, Manager text, D_Award integer, D_Expand integer)"];
    [db close];

    ;
    return YES;
}

- (void)setupYALTabBarController {
    YALFoldingTabBarController *tabBarController = (YALFoldingTabBarController *) self.window.rootViewController;

    //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"nearby_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"chats_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:[UIImage imageNamed:@"new_chat_icon"]];
    
    tabBarController.leftBarItems = @[item1, item2];

    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"profile_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:[UIImage imageNamed:@"new_chat_icon"]];
    
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"settings_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    tabBarController.rightBarItems = @[item3, item4];
    
    tabBarController.centerButtonImage = [UIImage imageNamed:@"plus_icon"];

    tabBarController.selectedIndex = 0;
    
    //customize tabBarView
    tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    tabBarController.tabBarView.backgroundColor = [UIColor clearColor];
    tabBarController.tabBarView.tabBarColor = [UIColor clearColor];
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
}

@end
