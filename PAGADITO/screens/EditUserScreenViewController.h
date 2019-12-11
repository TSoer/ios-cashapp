//
//  EditUserScreenViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/14.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditUserScreenViewController : UIViewController

@property(strong, nonatomic)NSMutableArray *user_array;
@property(nonatomic)NSInteger selected_index;

@property (weak, nonatomic) IBOutlet UIButton *roleSelectButton;
@property (weak, nonatomic) IBOutlet UIView *pincodeUIView;
@property (weak, nonatomic) IBOutlet UIView *checkBoxUIView;
@property (weak, nonatomic) IBOutlet UITableView *roleTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roleTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@property (weak, nonatomic) IBOutlet UITextField *firstnameTextView;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextView;
@property (weak, nonatomic) IBOutlet UITextField *pincodeTextView;


- (IBAction)backButtonAction:(id)sender;
- (IBAction)roleSelectButtonAction:(id)sender;
- (IBAction)switchViewAction:(id)sender;
- (IBAction)SaveandContinueButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pincodecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkboxcommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

NS_ASSUME_NONNULL_END
