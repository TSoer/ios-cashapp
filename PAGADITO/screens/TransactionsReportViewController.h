//
//  TransactionsReportViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/24.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransactionsReportViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *finishDatePicker;


- (IBAction)menuButtonAction:(id)sender;


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

- (IBAction)todaytransactionButtonAction:(id)sender;
- (IBAction)generatereportButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *todaytransactionButton;
@property (weak, nonatomic) IBOutlet UILabel *searchcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *startdatecommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *enddatecommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *generatereportButton;
@property (weak, nonatomic) IBOutlet UIButton *contactsupportButton;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;

@end

NS_ASSUME_NONNULL_END
