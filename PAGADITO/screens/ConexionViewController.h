//
//  ConexionViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/22.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConexionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *TransV;
@property (weak, nonatomic) IBOutlet UIView *SidePanel;
@property (weak, nonatomic) IBOutlet UILabel *sessionInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *uidTextField;
@property (weak, nonatomic) IBOutlet UITextField *wskTextField;
@property (weak, nonatomic) IBOutlet UITextField *idSecursalTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTerminalTextField;
@property (weak, nonatomic) IBOutlet UITextField *LlaveprivadaTextField;
@property (weak, nonatomic) IBOutlet UITextField *vectorTextField;

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
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)cancelChangeButtonAction:(id)sender;
- (IBAction)cerraturnoButtonAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *conexioncredentialcommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataencryptioncommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *keycommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorcommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelchangeButton;
@property (weak, nonatomic) IBOutlet UILabel *sessioncommentLabel;


@end

NS_ASSUME_NONNULL_END
