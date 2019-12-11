//
//  DeletTableViewCell.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/15.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "DeletTableViewCell.h"

@implementation DeletTableViewCell
@synthesize deletetableviewcell, cellIndex;

float deviceWidth = 0;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
        CGRect screen = [[UIScreen mainScreen] bounds];
        deviceWidth = CGRectGetWidth(screen);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%f, %f", userTableViewCellView.center.x, userTableViewCellView.center.y);
//    NSLog(@"////////////");

//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView: self];
//    startX = location.x - userTableViewCellView.center.x;
//    NSLog(@"%f,  %f", location.x, location.y);
//    NSLog(@"%f,  %f", userTableViewCellView.center.x, userTableViewCellView.center.y);

}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
//    NSLog(@"%f, %f", location.x, location.y);
//    NSLog(@"////////////");
    CGPoint culocation = deletetableviewcell.center;
    culocation.x = location.x;
    deletetableviewcell.center = culocation;
//    NSLog(@"%f, %f", userTableViewCellView.center.x, userTableViewCellView.center.y);
//    if(userTableViewCellView.center.x > deviceWidth / 4) {
//        [self autoMoveTableViewCellView:@"origin"];
//    } else {
//        [self autoMoveTableViewCellView:@"disappear"];
//    }
//    if(userTableViewCellView.center.x < deviceWidth / 4) {
//        if(!disappearStatus) {
//            [self autoMoveTableViewCellView:@"disappear"];
//        }
//    }

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%f, %f", userTableViewCellView.center.x, userTableViewCellView.center.y);
    if(deletetableviewcell.center.x > deviceWidth / 4) {
        [self autoMoveTableViewCellView:@"origin"];
    } else {
        [self autoMoveTableViewCellView:@"disappear"];
    }
}

-(void)autoMoveTableViewCellView: (NSString *)status {
    if([status isEqualToString:@"origin"]) {
        [UIView transitionWithView:deletetableviewcell duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->deletetableviewcell.frame;
            frame.origin.x = 0;
            self->deletetableviewcell.frame = frame;
        } completion:nil];
    } else if([status isEqualToString:@"disappear"]) {
        [UIView transitionWithView:deletetableviewcell duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->deletetableviewcell.frame;
            frame.origin.x = (0 - deviceWidth);
            self->deletetableviewcell.frame = frame;
        } completion:^(BOOL finished){
            [self.delegate reloadDeleteTableViewData:self :self->cellIndex];
        }];
    }
}

@end
