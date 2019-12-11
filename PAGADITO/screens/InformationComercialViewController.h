//
//  InformationComercialViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/21.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InformationComercialViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;

@property (weak, nonatomic) IBOutlet UITableView *currencyTableView;
@property (weak, nonatomic) IBOutlet UITextField *comercial_nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *terminal_nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectCurrencyButton;
@property (weak, nonatomic) IBOutlet UITextField *trade_numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *trade_emailLabel;


- (IBAction)backButtonAction:(id)sender;
- (IBAction)menuButtonAction:(id)sender;
- (IBAction)selectCurrencyButtonAction:(id)sender;



@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
@property (weak, nonatomic) IBOutlet UIButton *usuarioButton;
@property (weak, nonatomic) IBOutlet UIButton *turnoButton;
@property (weak, nonatomic) IBOutlet UIButton *canceltransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *newtransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *cerraturnoButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)homeButtonAction:(id)sender;
- (IBAction)configButtonAction:(id)sender;
- (IBAction)usuarioButtonAction:(id)sender;
- (IBAction)signoutButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;

- (IBAction)continuButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *maincommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *logoimagecommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;





@end

NS_ASSUME_NONNULL_END
