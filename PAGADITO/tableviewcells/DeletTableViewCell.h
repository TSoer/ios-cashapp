//
//  DeletTableViewCell.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/15.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol deleteTableViewCellDelegate;

@interface DeletTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoimageview;
@property (weak, nonatomic) IBOutlet UIView *deletetableviewcell;

@property(nonatomic)NSInteger cellIndex;

@property(nonatomic, assign) id<deleteTableViewCellDelegate> delegate;

@end

@protocol deleteTableViewCellDelegate <NSObject>

-(void)reloadDeleteTableViewData:(DeletTableViewCell *)sender :(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
