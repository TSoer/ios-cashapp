//
//  NewTransactionViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/14.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewTransactionViewController : UIViewController{
    
    IBOutlet UIView *TransV;
    IBOutlet UIView *SidePanel;
    IBOutlet UIButton *MenuBtn;
    
}

@property(nonatomic)IBOutlet UIButton *MenuBtn;
@property(nonatomic)IBOutlet UIView *SidePanel;
@property(nonatomic)IBOutlet UIView *TransV;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfocommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UILabel *amountTextFieldcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)oneButtonAction:(id)sender;
- (IBAction)twoButtonAction:(id)sender;
- (IBAction)threeButtonAction:(id)sender;
- (IBAction)fourButtonAction:(id)sender;
- (IBAction)fiveButtonAction:(id)sender;
- (IBAction)sixButtonAction:(id)sender;
- (IBAction)sevenButtonAction:(id)sender;
- (IBAction)eightButtonAction:(id)sender;
- (IBAction)nineButtonAction:(id)sender;
- (IBAction)zeroButtonAction:(id)sender;
- (IBAction)pointButtonAction:(id)sender;
- (IBAction)clearButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
@property (weak, nonatomic) IBOutlet UIButton *usuarioButton;
@property (weak, nonatomic) IBOutlet UIButton *turnoButton;
@property (weak, nonatomic) IBOutlet UIButton *canceltransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *newtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *cerraturnoButton;

- (IBAction)newtransationButtonAction:(id)sender;
- (IBAction)signoutButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;

- (IBAction)continueButtonAction:(id)sender;

- (IBAction)menunewtransctionButtonAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
