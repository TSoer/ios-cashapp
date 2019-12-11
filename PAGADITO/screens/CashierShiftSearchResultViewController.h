//
//  CashierShiftSearchResultViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/24.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashierShiftSearchResultViewController : UIViewController

@property(strong, nonatomic)NSString *fecha_inicio;
@property(strong, nonatomic)NSString *fecha_fin;
@property(strong, nonatomic)NSString *userCajero;
@property(strong, nonatomic)NSString *codeShift;

@property (weak, nonatomic) IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;
@property (weak, nonatomic) IBOutlet UITableView *shiftListTableView;
@property (weak, nonatomic) IBOutlet UILabel *shiftarrayCountLabel;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)modifysearchButtonAction:(id)sender;

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
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *modifysearchButton;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;


@end

NS_ASSUME_NONNULL_END
