//
//  CancelTransactionTableViewCell.h
//  PAGADITO
//
//  Created by Water Flower on 2019/2/11.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol cancelTransactionTableViewCellDelegate;

@interface CancelTransactionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cancelTransactionTableCellView;
@property (weak, nonatomic) IBOutlet UILabel *transaction_amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *transaction_ernLabel;
@property (weak, nonatomic) IBOutlet UILabel *transaction_datetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transaction_referenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *transaction_statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *erncommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fechacommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *referencecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuscommentLabel;

@property(nonatomic)NSInteger selected_index;

@property(nonatomic, assign) id<cancelTransactionTableViewCellDelegate> delegate;

@end

@protocol cancelTransactionTableViewCellDelegate <NSObject>

-(void)reloadCancelTransactionTableViewData:(CancelTransactionTableViewCell *)sender :(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
