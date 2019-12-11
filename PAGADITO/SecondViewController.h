//
//  SecondViewController.h
//  PAGADITO
//
//  Created by Adriana Roldán on 12/13/18.
//  Copyright © 2018 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    
    IBOutlet UIView *TransV;
    IBOutlet UIView *SidePanel;
    IBOutlet UIButton *MenuBtn;
    
}

@property(nonatomic)IBOutlet UIButton *MenuBtn;
@property(nonatomic)IBOutlet UIView *SidePanel;
@property(nonatomic)IBOutlet UIView *TransV;

@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;

@property (weak, nonatomic) IBOutlet UIButton *DashboardButton1;
@property (weak, nonatomic) IBOutlet UIButton *DashboardButton2;
@property (weak, nonatomic) IBOutlet UIButton *DashboardButton3;
@property (weak, nonatomic) IBOutlet UIButton *DashboardButton4;

- (IBAction)DashboardButton1Action:(id)sender;
- (IBAction)DashboardButton2Action:(id)sender;
- (IBAction)DashboardButton3Action:(id)sender;
- (IBAction)DashboardButton4Action:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *privilidgeID3DashboardView;
@property (weak, nonatomic) IBOutlet UILabel *priv3FullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priv3CurrentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priv3ShiftCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *priv3ProcessTransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *priv3VoidTransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *priv3EndShiftButton;
@property (weak, nonatomic) IBOutlet UIButton *priv3SignoutButton;

- (IBAction)signoutButtonAction:(id)sender;
- (IBAction)closeShiftButtonAction:(id)sender;


////  side menu buttons  //////
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
@property (weak, nonatomic) IBOutlet UIButton *usuarioButton;
@property (weak, nonatomic) IBOutlet UIButton *turnoButton;
@property (weak, nonatomic) IBOutlet UIButton *canceltransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *newtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *cerraturnoButton;

- (IBAction)homeButtonAction:(id)sender;
- (IBAction)turnoButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;
- (IBAction)configButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shorcutLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactsupportButton;
@property (weak, nonatomic) IBOutlet UIButton *signoutButton;




@end
