//
//  ShiftListTableViewCell.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/16.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShiftListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *codeShiftLabel;
@property (weak, nonatomic) IBOutlet UILabel *estadoLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fachaInicioLabel;
@property (weak, nonatomic) IBOutlet UILabel *fachaFinLabel;

@property (weak, nonatomic) IBOutlet UILabel *fechaInicio_commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *Fin_commentLabel;

@end

NS_ASSUME_NONNULL_END
