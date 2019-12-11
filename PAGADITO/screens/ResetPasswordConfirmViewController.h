//
//  ResetPasswordConfirmViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/21.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResetPasswordConfirmViewController : UIViewController
@property(strong, nonatomic)NSString *idUser;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UIView *TransV;

- (IBAction)saveButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *successAlertView;
- (IBAction)successAlertViewOKButtonAction:(id)sender;
- (IBAction)backButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *successcommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

NS_ASSUME_NONNULL_END
