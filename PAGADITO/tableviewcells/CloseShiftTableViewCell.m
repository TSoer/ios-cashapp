//
//  CloseShiftTableViewCell.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/18.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "CloseShiftTableViewCell.h"

@implementation CloseShiftTableViewCell
@synthesize closeShiftTableCellView, cell_index;

float phoneWidth = 0;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGRect deviceScreen = [[UIScreen mainScreen] bounds];
    phoneWidth = CGRectGetWidth(deviceScreen);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint culocation = closeShiftTableCellView.center;
    culocation.x = location.x;
    closeShiftTableCellView.center = culocation;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(closeShiftTableCellView.center.x > phoneWidth / 4) {
        [self autoMoveTableViewCellView:@"origin"];
    } else {
        [self autoMoveTableViewCellView:@"disappear"];
    }
}

-(void)autoMoveTableViewCellView: (NSString *)status {
    if([status isEqualToString:@"origin"]) {
        NSLog(@"origin");
        [UIView transitionWithView:closeShiftTableCellView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->closeShiftTableCellView.frame;
            frame.origin.x = 0;
            self->closeShiftTableCellView.frame = frame;
        } completion:nil];
    } else if([status isEqualToString:@"disappear"]) {
        NSLog(@"disappear");
        [UIView transitionWithView:closeShiftTableCellView duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->closeShiftTableCellView.frame;
            frame.origin.x = (0 - phoneWidth);
            self->closeShiftTableCellView.frame = frame;
        } completion:^(BOOL finished){
            [self.delegate reloadCloseShiftTableViewData:self :self->cell_index];
        }];


    }
}

@end
