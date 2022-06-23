//
//  TweetCellTableViewCell.m
//  twitter
//
//  Created by Harini Sundaram on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
@implementation TweetCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.faveNum.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
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
@end
