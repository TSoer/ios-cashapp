//
//  ResetPasswordWSKViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/21.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResetPasswordWSKViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *wskTextField;
@property (weak, nonatomic) IBOutlet UIView *TransV;

- (IBAction)continueButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *failAlertView;
- (IBAction)failOkButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UILabel *failcommentLabel;

@end

NS_ASSUME_NONNULL_END
