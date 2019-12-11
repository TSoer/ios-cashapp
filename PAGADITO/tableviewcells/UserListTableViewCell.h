//
//  UserListTableViewCell.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/13.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol myUITableViewCellDelegate;

@interface UserListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *roleImageView;

//@property (weak, nonatomic) IBOutlet UIView *userTableViewCellView;

//@property(nonatomic)NSInteger cellIndex;
//
//@property(nonatomic, assign) id<myUITableViewCellDelegate> delegate;
//
@end
//@protocol myUITableViewCellDelegate <NSObject>
//
//-(void)reloadTableView:(UserListTableViewCell *)sender :(NSInteger)index;
//
//@end

NS_ASSUME_NONNULL_END
