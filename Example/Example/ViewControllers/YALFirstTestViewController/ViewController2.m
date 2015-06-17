//
//  ViewController.m
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import "ViewController2.h"
#import "AppDelegate.h"
#import "FMDB.h"
@interface ViewController2 (){
    NSMutableDictionary *eventsByDate;
}
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *pay;

@end

@implementation ViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    [backgroundImage setImage:[UIImage imageNamed:@"mb_1"]];
    [self.view insertSubview:backgroundImage atIndex:0];
    
    self.calendarContentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.calendarContentView.layer.cornerRadius = 12;
    //self.calendarMenuView.layer.cornerRadius = 8;
    self.calendarMenuView.backgroundColor = [UIColor clearColor];
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 2.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            

            NSString *month = [NSString stringWithFormat:@"%ld月",(long)currentMonthIndex];
            
            return [NSString stringWithFormat:@"%@", month];
        };
    }
    
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self createRandomEvents];
    
    [self.calendar reloadData];
    

   // NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    


    
    
}
- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _money.text = [NSString stringWithFormat:@"￥%ld", (long)[defaults integerForKey:@"myMoney"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    FMResultSet *s = [db executeQuery:@"SELECT * FROM DepartmentList"];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    NSMutableArray *awards = [[NSMutableArray alloc] init];
    NSMutableArray *expands = [[NSMutableArray alloc] init];
    while ([s next]) {
        [names addObject:[s stringForColumn:@"D_Name"]];
        [awards addObject: [NSNumber numberWithInt:[s intForColumn:@"D_Award"]]];
        [expands addObject: [NSNumber numberWithInt:[s intForColumn:@"D_Expand"]]];
        
    }
    [db close];
    int allDPay = 0;
    int i = 0;
    for (NSString* name in names) {
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        FMResultSet *s2 = [db executeQuery:@"SELECT * FROM PersonList WHERE Department = ?", name];
        int allToPay = 0;
        while ([s2 next]) {
            int basePay = [s2 intForColumn:@"BasePay"];
            int bonus = [s2 intForColumn:@"Bonus"];
            int award = [s2 intForColumn:@"Award"];
            int insurance = [s2 intForColumn:@"Insurance"];
            int fund = [s2 intForColumn:@"Fund"];
            int pay = basePay + bonus + award - insurance - fund;
            allToPay = allToPay + pay;
        }
        allToPay = allToPay + [[awards objectAtIndex:i] intValue] - [[expands objectAtIndex:i] intValue];
        allDPay = allDPay + allToPay;
        [db close];
        i++;
    }
    
    _pay.text = [NSString stringWithFormat:@"￥%d", allDPay];

}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, (unsigned long)[events count]);
}

- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded");
}

- (void)calendarDidLoadNextPage
{
    NSLog(@"Next page loaded");
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
             
        [eventsByDate[key] addObject:randomDate];
    }
}

@end
