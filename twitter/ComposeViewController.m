//
//  ComposeViewController.m
//  twitter
//
//  Created by Harini Sundaram on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textBox;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)publishTweet:(id)sender {
//    NSIndexPath * myIndexPath = [self.tableView indexPathForCell:sender];
    NSString *text_field = [self.textBox text];
//    NSLog(@"%", text_field);
    [[APIManager shared] postStatusWithText:text_field completion:^(Tweet *tweet, NSError * error) {
        if (tweet) {
            NSLog(@"YAY");
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            NSLog(@"Big Sad");
        }

    }];

}
@end
