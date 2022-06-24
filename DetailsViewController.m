//
//  DetailsViewController.m
//  twitter
//
//  Created by Harini Sundaram on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import "DateTools.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *mainTweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *replyNum;
@property (weak, nonatomic) IBOutlet UILabel *retweetNum;
@property (weak, nonatomic) IBOutlet UIButton *LikeButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *favorNum;
//@property (strong, nonatomic) Tweet* tweet;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.author.text = self.tweet.user.name;
    self.screenName.text =[@"@" stringByAppendingString :self.tweet.user.screenName];
    self.date.text = [self.tweet.date.shortTimeAgoSinceNow stringByAppendingString:@" ago"];
    self.mainTweet.text  = self.tweet.text;
    self.retweetNum.text =[NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.favorNum.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.replyNum.text = @"0";
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    NSLog(@"%", URLString);
//    cell.profilePic.image = urlData;
    [self.profileView setImageWithURL: url ] ;
    
//    self.replyNum.tex
    
    // Do any additional setup after loading the view.
}

- (IBAction)didTapFavorite:(id)sender {
//    UIButton *btn = (UIButton *)sender;
    if (!self.tweet.favorited){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    }
        
        [[APIManager shared] favorite:self.tweet secondValue: self.tweet.favorited completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    [self refreshData];
    
}
- (IBAction)didTapRetweet:(id)sender {
    
    if (!self.tweet.retweeted){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
    }
        
        [[APIManager shared] retweet:self.tweet secondValue: self.tweet.retweeted completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    [self refreshData];
}



- (void)refreshData {
    self.favorNum.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.retweetNum.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
//    if (self.tweet.favorited){
    if (self.tweet.favorited) {
        [self.LikeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    }
    else{
        [self.LikeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    
    if(self.tweet.retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }

    
    
    
    
    
//        self.
//    }
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
