//
//  TransactionsViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/23.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransactionsViewController : UIViewController

@property(strong, nonatomic)NSString *sourceVC;
@property(strong, nonatomic)NSString *shift_code;
@property(strong, nonatomic)NSString *start_datetime;
@property(strong, nonatomic)NSString *finish_datetime;
@property(strong, nonatomic)NSString *userCajero;
@property(strong, nonatomic)NSString *selectedTurnoCode;


@property (weak, nonatomic) IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnocodigoLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnocodigoTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *transactionTableView;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)backButtonAction:(id)sender;

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
@property (weak, nonatomic) IBOutlet UILabel *exportcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;


@end

NS_ASSUME_NONNULL_END
