//
//  ViewController.m
//  RGCardViewLayout
//
//  Created by ROBERA GELETA on 1/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//
#define TAG 99

#import "ViewController.h"
#import "RKCardView.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextFieldViewController.h"
#import "FMDB.h"
#import "AppDelegate.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) RKCardView* cardView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property NSInteger numOfRows;
@property NSInteger index;
@property NSString *Name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    [backgroundImage setImage:[UIImage imageNamed:@"mb_1"]];
    [self.view insertSubview:backgroundImage atIndex:0];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    FMResultSet *s = [db executeQuery:@"SELECT COUNT(*) FROM DepartmentList"];
    if ([s next]) {
        _numOfRows = [s intForColumnIndex:0];
    }
    [db close];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    FMResultSet *s = [db executeQuery:@"SELECT COUNT(*) FROM DepartmentList"];
    if ([s next]) {
        _numOfRows = [s intForColumnIndex:0];
        NSLog(@"numberOf Row: %ld", (long)_numOfRows);
    }
    [db close];
    [_collectView reloadData];
}

- (void)extraRightItemDidPressed {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[JVFloatLabeledTextFieldViewController alloc] initForNew:-1]];
    [self presentViewController:nvc animated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  _numOfRows;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _cardView= [[RKCardView alloc]initWithFrame:CGRectMake(0, 0, 260, cell.frame.size.height)];
    int k = arc4random()%2;
    NSString *str1 = [NSString stringWithFormat:@"back%d", k];
    _cardView.coverImageView.image = [UIImage imageNamed:str1];
    int j = arc4random()%5;
    NSString *str2 = [NSString stringWithFormat:@"img_0%d", j];
    _cardView.profileImageView.image = [UIImage imageNamed:str2];
    //_cardView.titleLabel.text = @"市场部";
    [_cardView.detail addTarget:self action:@selector(popupDetail:) forControlEvents:UIControlEventTouchUpInside];
    [_cardView.detail setTag:indexPath.section];
    //[cardView addBlur]; // comment this out if you don't want blur
    [_cardView addShadow]; // comment this out if you don't want a shadow
    [cell insertSubview:_cardView atIndex:0];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
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
        if (i == indexPath.section) {
            name = [s stringForColumn:@"D_Name"];
            _Name = name;
            [_cardView.titleLabel setText:name];
            manager = [s stringForColumn:@"Manager"];
            if (name) {
                [_cardView.managerLabel setText:manager];
            }
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
    FMResultSet *s2 = [db executeQuery:@"SELECT BasePay, Bonus, Award, Insurance, Fund FROM PersonList WHERE Department = ?", name];
    i = 0;
    int allToPay = 0;
    while ([s2 next]) {
        int basePay = [s2 intForColumn:@"BasePay"];
        int bonus = [s2 intForColumn:@"Bonus"];
        int award = [s2 intForColumn:@"Award"];
        int insurance = [s2 intForColumn:@"Insurance"];
        int fund = [s2 intForColumn:@"Fund"];
        int pay = basePay + bonus + award - insurance - fund;
        allToPay = allToPay + pay;

        i++;
    }
    allToPay = allToPay + award - expand;
    [_cardView.salaryNum setText:[NSString stringWithFormat:@"￥%d", allToPay]];
    [db close];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    FMResultSet *s3 = [db executeQuery:@"SELECT COUNT(*) FROM PersonList WHERE Department = ?", name];
    int numOfP = 0;
    i = 0;
    if ([s3 next]) {
        numOfP = [s3 intForColumnIndex:0];
        [_cardView.memberNum setText:[NSString stringWithFormat:@"%d人", numOfP]];
    }
    [db close];
    
       //[self configureCell:cell withIndexPath:indexPath];
    return cell;
}


- (void)popupDetail:(UIButton*)button {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[JVFloatLabeledTextFieldViewController alloc] initForNew:button.tag title:_Name]];
    [self presentViewController:nvc animated:YES completion:^{}];
}


//- (void)configureCell:(UICollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
//{
//    UIView  *subview = [cell.contentView viewWithTag:TAG];
//    [subview removeFromSuperview];
//
//    switch (indexPath.section) {
//        case 0:
//
//            break;
//        case 1:
//
//            break;
//        case 2:
//
//            break;
//        case 3:
//
//            break;
//        case 4:
//            break;
//        default:
//            break;
//    }
//    
//}


@end
