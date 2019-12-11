//
//  CancelTransactionTableViewCell.m
//  PAGADITO
//
//  Created by Water Flower on 2019/2/11.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "CancelTransactionTableViewCell.h"

@implementation CancelTransactionTableViewCell
@synthesize cancelTransactionTableCellView, selected_index;

float PhoneWidth = 0;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGRect deviceScreen = [[UIScreen mainScreen] bounds];
    PhoneWidth = CGRectGetWidth(deviceScreen);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint culocation = cancelTransactionTableCellView.center;
    culocation.x = location.x;
    cancelTransactionTableCellView.center = culocation;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(cancelTransactionTableCellView.center.x > PhoneWidth / 4) {
        [self autoMoveTableViewCellView:@"origin"];
    } else {
        [self autoMoveTableViewCellView:@"disappear"];
    }
}

-(void)autoMoveTableViewCellView: (NSString *)status {
    if([status isEqualToString:@"origin"]) {
        [UIView transitionWithView:cancelTransactionTableCellView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->cancelTransactionTableCellView.frame;
            frame.origin.x = 0;
            self->cancelTransactionTableCellView.frame = frame;
        } completion:nil];
    } else if([status isEqualToString:@"disappear"]) {
        [UIView transitionWithView:cancelTransactionTableCellView duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->cancelTransactionTableCellView.frame;
            frame.origin.x = (0 - PhoneWidth);
            self->cancelTransactionTableCellView.frame = frame;
        } completion:^(BOOL finished){
            [self.delegate reloadCancelTransactionTableViewData:self :self->selected_index];
        }];
    }
}

@end
