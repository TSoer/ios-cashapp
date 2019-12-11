//
//  DeleteUserViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/13.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteUserViewController : UIViewController{
    
    IBOutlet UIView *TransV;
    IBOutlet UIView *SidePanel;
    IBOutlet UIButton *MenuBtn;
    
}

@property(nonatomic)IBOutlet UIButton *MenuBtn;
@property(nonatomic)IBOutlet UIView *SidePanel;
@property(nonatomic)IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;


@property(strong, nonatomic)NSMutableArray *user_array;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)createUserButtonAction:(id)sender;
- (IBAction)editUserButtonAction:(id)sender;
- (IBAction)searchUserButtonAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *deleteAlertView;
@property (weak, nonatomic) IBOutlet UILabel *deleteUserNameLabel;
- (IBAction)deleteUserCancelButtonAction:(id)sender;
- (IBAction)deleteUserOKButtonAction:(id)sender;

/////// side menu buttons configure /////////
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
@property (weak, nonatomic) IBOutlet UIButton *usuarioButton;
@property (weak, nonatomic) IBOutlet UIButton *turnoButton;
@property (weak, nonatomic) IBOutlet UIButton *canceltransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *newtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *cerraturnoButton;

- (IBAction)logoutButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *deletecommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;


@end

NS_ASSUME_NONNULL_END
