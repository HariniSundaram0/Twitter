//
//  TweetCellTableViewCell.h
//  twitter
//
//  Created by Harini Sundaram on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "DateTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *faveNum;
@property (weak, nonatomic) IBOutlet UILabel *retweetNum;
@property (weak, nonatomic) IBOutlet UILabel *replyNum;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIButton *LikeButton;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property Tweet * tweet;
-(void) formatDate: (NSDate * ) date;


@end


NS_ASSUME_NONNULL_END
