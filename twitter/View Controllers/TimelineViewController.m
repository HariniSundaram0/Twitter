//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "TweetCellTableViewCell.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DateTools.h"

@interface TimelineViewController () <ComposeViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapLogout:(id)sender;
@property NSMutableArray *arrayOfTweets;

@end

@implementation TimelineViewController
- (IBAction)didTapLogout:(id)sender {
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];

    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (Tweet *curr_tweet in tweets) {
//                NSString *text = curr_tweet.text;
//                NSLog(@"%@", text);
//            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
   
}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (Tweet *curr_tweet in tweets) {
//                NSString *text = curr_tweet.text;
//                NSLog(@"%@", text);
//            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
           // ... Use the new data to update the data source ...

           // Reload the tableView now that there is new data
            [self.tableView reloadData];

           // Tell the refreshControl to stop spinning
            [refreshControl endRefreshing];

     

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
//    return 20;
    NSLog(@"%", self.arrayOfTweets.count);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"tweetFormat"];
    Tweet *curr_tweet = self.arrayOfTweets[indexPath.row];

    NSString *URLString = curr_tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    NSLog(@"%", URLString);
//    cell.profilePic.image = urlData;
    [cell.profilePic setImageWithURL: url ] ;
    cell.author.text = curr_tweet.user.name;
    cell.handle.text = [@"@" stringByAppendingString :curr_tweet.user.screenName];
//    cell.date.text = curr_tweet.createdAtString;
    
//    NSString * curr_date = curr_tweet.createdAtString;
////    NSLog(@"%@", curr_date);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
//    NSDate *date = [formatter dateFromString:curr_date];
    
    NSLog(@"%@", curr_tweet.date.shortTimeAgoSinceNow);
    
    NSString *final_date = [curr_tweet.date.shortTimeAgoSinceNow stringByAppendingString:@" ago"];
    [cell.date setText: final_date];
//    [cell formatDate:curr_tweet.date.shortTimeAgoSinceNow];
    
//
//    if (date.shortTimeAgoSinceNow == NULL){
//        cell.date.text =  date.timeAgoSinceNow;
//    }
//    else {
//        cell.date.text = date.shortTimeAgoSinceNow;
//    }
    
    
    cell.tweetText.text = curr_tweet.text;
    cell.retweetNum.text =[NSString stringWithFormat:@"%i", curr_tweet.retweetCount];
    cell.faveNum.text = [NSString stringWithFormat:@"%i", curr_tweet.favoriteCount];
    cell.tweet = curr_tweet; 
    cell.replyNum.text = @"0";
    
    
    return cell;
    
    
    
}
- (void)didTweet:(Tweet *)tweet{
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
    
    
//    NSLog(@"%@", dataToPass);
    
}


@end
