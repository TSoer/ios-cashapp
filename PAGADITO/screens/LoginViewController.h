//
//  LoginViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/5.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *comment1Label;
@property (weak, nonatomic) IBOutlet UILabel *comment2Label;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotpasswordButton;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;


- (IBAction)LoginButtonAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
