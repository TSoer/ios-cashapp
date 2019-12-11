//
//  CancelTransactionViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/2/10.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CancelTransactionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UIView *TransV;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)menucanceltransactionButtonAction:(id)sender;
- (IBAction)menusignoutButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *transactionTableView;
@property (weak, nonatomic) IBOutlet UILabel *turnoCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *canceltransactionAlertView;
@property (weak, nonatomic) IBOutlet UILabel *alertTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *reasonTextField;


@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
@property (weak, nonatomic) IBOutlet UIButton *usuarioButton;
@property (weak, nonatomic) IBOutlet UIButton *turnoButton;
@property (weak, nonatomic) IBOutlet UIButton *canceltransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *newtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *cerraturnoButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnocodecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *removecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *notecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptioncommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfocommentLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)removeButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
