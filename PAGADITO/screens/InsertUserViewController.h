//
//  InsertUserViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/13.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InsertUserViewController : UIViewController
@property(strong, nonatomic)NSString *user_role;

@property (weak, nonatomic) IBOutlet UIButton *roleSelectButton;
@property (weak, nonatomic) IBOutlet UIView *checkBoxUIView;
@property (weak, nonatomic) IBOutlet UIView *pincodeUIView;
@property (weak, nonatomic) IBOutlet UITableView *roleTableVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roleTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISwitch *checkSwitchView;
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextView;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextView;
@property (weak, nonatomic) IBOutlet UITextField *pincodeTextView;

- (IBAction)backButtonAction:(id)sender;

- (IBAction)roleSelectButtonAction:(id)sender;
- (IBAction)switchViewAction:(id)sender;
- (IBAction)createuserButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pincodecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkboxcommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *continuButton;

@end

NS_ASSUME_NONNULL_END
