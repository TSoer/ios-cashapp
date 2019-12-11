//
//  TransactionResultViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/2/8.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionResultSignatureView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransactionResultViewController : UIViewController

@property(strong, nonatomic) NSDictionary *dataTransaction;

@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UIView *TransV;

- (IBAction)menuButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
@property (weak, nonatomic) IBOutlet UIButton *usuarioButton;
@property (weak, nonatomic) IBOutlet UIButton *turnoButton;
@property (weak, nonatomic) IBOutlet UIButton *canceltransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *newtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *cerraturnoButton;

- (IBAction)signoutButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *successcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullnamecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardnumbercommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *signcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userInfocommentLabel;

@property (weak, nonatomic) IBOutlet UIButton *mainnewtransButton;
@property (weak, nonatomic) IBOutlet UIButton *maincanceltransButton;
@property (weak, nonatomic) IBOutlet UIButton *submitemailButton;

- (IBAction)emailSendButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet TransactionResultSignatureView *signatureView;
- (IBAction)signatureViewClearButtonAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
