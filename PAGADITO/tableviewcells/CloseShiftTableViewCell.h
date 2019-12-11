//
//  CloseShiftTableViewCell.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/18.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol closeShiftTableViewCellDelegate;

@interface CloseShiftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *closeEstadoLabel;
@property (weak, nonatomic) IBOutlet UILabel *closeCodeShiftLabel;
@property (weak, nonatomic) IBOutlet UILabel *closeUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *closeFachaInicioLabel;
@property (weak, nonatomic) IBOutlet UILabel *closeFachaFinLabel;
@property (weak, nonatomic) IBOutlet UIView *closeShiftTableCellView;

@property (weak, nonatomic) IBOutlet UILabel *fechaIniciocommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fechaFincommentLabel;


@property(nonatomic)NSInteger cell_index;

@property(nonatomic, assign) id<closeShiftTableViewCellDelegate> delegate;

@end

@protocol closeShiftTableViewCellDelegate <NSObject>

-(void)reloadCloseShiftTableViewData:(CloseShiftTableViewCell *)sender :(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
