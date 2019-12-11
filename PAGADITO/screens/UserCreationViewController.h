//
//  UserCreationViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/7.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCreationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *roleTableView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmpwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *selectRoleButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property (weak, nonatomic) IBOutlet UIView *checkBoxUIView;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UIView *pincodeUIView;
@property (weak, nonatomic) IBOutlet UITextField *pincodeTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roleTableViewHeightConstraint;


- (IBAction)continueButtonAction:(id)sender;
- (IBAction)selectRoleButtonAction:(id)sender;
- (IBAction)switchAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkboxCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *pincodeCommentLabel;



@end

NS_ASSUME_NONNULL_END
