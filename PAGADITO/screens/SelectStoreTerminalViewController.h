//
//  SelectStoreTerminalViewController.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/5.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectStoreTerminalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *storeTableView;
@property (weak, nonatomic) IBOutlet UIButton *selectStoreButton;
- (IBAction)selectStoreButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *terminalTableView;
@property (weak, nonatomic) IBOutlet UIButton *selectTerminalButton;
- (IBAction)selectTerminalButtonAction:(id)sender;

@property (strong, nonatomic) NSXMLParser *xmlStoreParser;
@property (strong, nonatomic) NSXMLParser *xmlTerminalParser;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *terminalTableViewHeightConstraint;


- (IBAction)continueButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectStoreCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectTerminalCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;


@end

NS_ASSUME_NONNULL_END
