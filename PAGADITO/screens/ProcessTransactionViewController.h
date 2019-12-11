//
//  ProcessTransactionViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/2/4.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDeviceController.h"
#import "BBDeviceOTAController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProcessTransactionViewController : UIViewController <BBDeviceControllerDelegate>{
    //LECTOR
@private
    BOOL isAutoSetAmount;
    BOOL isAutoSelectApplication;
    BOOL isAutoEnterPin;
    BOOL isAutoFinalConfirm;
    BOOL isAutoSendOnlineProcessResult;
    BOOL isAutoConnectLastBTDevice;
    
    BOOL isBadSwiped;
    BOOL isWrongPin;
    BOOL isCanceledPin;
    BOOL isCheckCardOnly;
    BOOL isSwipeCardOnly;
    BOOL isClickedStartTransactionButton;
    
}

@property(strong, nonatomic) NSString *transactionAmount;

- (IBAction)menuButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UIView *SidePanel;

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

@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *monthTableVIew;
@property (weak, nonatomic) IBOutlet UIButton *monthselectButton;
@property (weak, nonatomic) IBOutlet UITableView *yearTableView;
@property (weak, nonatomic) IBOutlet UIButton *yearselectButton;
@property (weak, nonatomic) IBOutlet UITextField *CVVTextField;
@property (weak, nonatomic) IBOutlet UIImageView *crediccardImageView;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UISwitch *taxSwitchButton;


- (IBAction)CVVhelpButtonAction:(id)sender;
- (IBAction)monthselectButtonAction:(id)sender;
- (IBAction)yearselectButtonAction:(id)sender;
- (IBAction)switchButtonAction:(id)sender;
- (IBAction)processtransactionButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *maincommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardholdernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiredateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkBoxLabel;
@property (weak, nonatomic) IBOutlet UIButton *processtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *contactsupportButton;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *BTDeviceListView;
@property (weak, nonatomic) IBOutlet UILabel *devicecommentLabel;
@property (weak, nonatomic) IBOutlet UITableView *BTDeviceTable;
- (IBAction)BTDeviceListViewCloseButtonAction:(id)sender;
- (IBAction)btnAction_StartEMV:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cardReadButton;

@end

NS_ASSUME_NONNULL_END
