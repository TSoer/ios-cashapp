//
//  ShiftListTableViewCell.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/16.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "ShiftListTableViewCell.h"

@implementation ShiftListTableViewCell

@synthesize estadoLabel, codeShiftLabel, usernameLabel, fachaInicioLabel, fachaFinLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
