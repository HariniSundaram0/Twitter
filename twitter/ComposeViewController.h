//
//  ComposeViewController.h
//  twitter
//
//  Created by Harini Sundaram on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewDelegate <NSObject>

-(void)didTweet:(Tweet *)tweet;

@end


@interface ComposeViewController : UIViewController
@property (weak, nonatomic) id <ComposeViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
