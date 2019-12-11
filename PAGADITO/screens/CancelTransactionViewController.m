//
//  CancelTransactionViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/2/10.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "CancelTransactionViewController.h"
#import "Global.h"
#import "WelcomeViewController.h"
#import "AFNetworking.h"
#import "../tableviewcells/CancelTransactionTableViewCell.h"

@interface CancelTransactionViewController ()<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property(strong, nonatomic) NSMutableArray *transactionArray;
@property (strong, nonatomic) NSXMLParser *xmlTransactionsParser;
@property(strong, nonatomic)NSArray *transaction;
@property(strong, nonatomic)NSArray *canceled_transaction;
@property(nonatomic) NSInteger canceled_index;

@property(strong, nonatomic) NSDictionary *dataTransaction;

@property(strong, nonatomic) NSString *transaction_status;
@property(strong, nonatomic) NSString *transaction_token;
@property(strong, nonatomic) NSString *transaction_ern;
@property(strong, nonatomic) NSString *transaction_amount;
@property(strong, nonatomic) NSString *transaction_datetime;
@property(strong, nonatomic) NSString *transaction_reference;

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@end

@implementation CancelTransactionViewController
@synthesize SidePanel, TransV, transactionTableView, turnoCodeLabel, sessionInfoLabel, canceltransactionAlertView, alertTitleLabel, emailTextField, reasonTextField, cancelButton, removeButton;
@synthesize homeButton, reportButton, configButton, usuarioButton, turnoButton, canceltransactionButton, newtransactionButton, logoutButton, cerraturnoButton;
@synthesize titleLabel, turnocodecommentLabel, notecommentLabel, descriptioncommentLabel, removecommentLabel, sessionInfocommentLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //////  init transaction array  //////
    self.transactionArray = [[NSMutableArray alloc] init];
    self.canceled_index = -1;
    
    Global *globals = [Global sharedInstance];
    
    self.turnoCodeLabel.text = globals.codeShift;
    
    if(globals.selected_language == 0) {
        self.titleLabel.text = @"Anular Transacciones";
        self.turnocodecommentLabel.text = @"Turno código:";
        self.removecommentLabel.text = @"Desliza a la izquierda la transacción a anular.";
        self.notecommentLabel.text = @"Nota:";
        self.descriptioncommentLabel.text = @"Solo puedes anular transacciones de los últimos 30 min.";
        self.sessionInfocommentLabel.text = @"Sesión iniciada:";
        self.emailTextField.placeholder = @"Correo Electrónico";
        self.reasonTextField.placeholder = @"Motivo";
        [self.cancelButton setTitle:@"Cancelar" forState:UIControlStateNormal];
        [self.removeButton setTitle:@"Anular" forState:UIControlStateNormal];
    } else {
        self.titleLabel.text = @"Cancel Transactions";
        self.turnocodecommentLabel.text = @"Shift Code:";
        self.removecommentLabel.text = @"Swipe the transaction to be canceled to the left.";
        self.notecommentLabel.text = @"Note:";
        self.descriptioncommentLabel.text = @"You can only cancel transactions for the last 30 min.";
        self.sessionInfocommentLabel.text = @"Session started:";
        self.emailTextField.placeholder = @"Email";
        self.reasonTextField.placeholder = @"Reason";
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    }
    
    [self setMenuButtonsicon];
    
    //session info label
    sessionInfoLabel.text = [NSString stringWithFormat:@"%@ / %@", globals.username, globals.nombreComercio];;
    
    ////   hide side menu panel tap event
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSidePanel:)];
    tapper.numberOfTapsRequired = 1;
    [TransV addGestureRecognizer:tapper];
    
    //////////// init for activity indicator  /////////
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    
    ///////  dismiss keyboard  //////
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    
    //set dashborad buttons background image according to priviledge ID
    if([globals.idPrivilegio isEqualToString:@"1"]) {
        ///////  side menu button config   ////////////
        CGRect homeButtonFrame = self.homeButton.frame;
        homeButtonFrame.origin.x = 0;
        homeButtonFrame.origin.y = 0;
        self.homeButton.frame = homeButtonFrame;
        UIView *homelineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, homeButton.frame.size.width, 1)];
        homelineView.backgroundColor = [UIColor lightGrayColor];
        [self.homeButton addSubview:homelineView];
        
        CGRect reportButtonFrame = self.reportButton.frame;
        reportButtonFrame.origin.x = 0;
        reportButtonFrame.origin.y = 60;
        self.reportButton.frame = reportButtonFrame;
        UIView *reportlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, reportButton.frame.size.width, 1)];
        reportlineView.backgroundColor = [UIColor lightGrayColor];
        [self.reportButton addSubview:reportlineView];
        
        CGRect configureButtonFrame = self.configButton.frame;
        configureButtonFrame.origin.x = 0;
        configureButtonFrame.origin.y = 120;
        self.configButton.frame = configureButtonFrame;
        UIView *configurelineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, configButton.frame.size.width, 1)];
        configurelineView.backgroundColor = [UIColor lightGrayColor];
        [self.configButton addSubview:configurelineView];
        
        CGRect usuarioButtonFrame = self.usuarioButton.frame;
        usuarioButtonFrame.origin.x = 0;
        usuarioButtonFrame.origin.y = 180;
        self.usuarioButton.frame = usuarioButtonFrame;
        UIView *usuariolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, usuarioButton.frame.size.width, 1)];
        usuariolineView.backgroundColor = [UIColor lightGrayColor];
        [self.usuarioButton addSubview:usuariolineView];
        
        [self.turnoButton setHidden:YES];
        [self.canceltransactionButton setHidden:YES];
        [self.newtransactionButton setHidden:YES];
        [self.cerraturnoButton setHidden:YES];
        ////////////////////////////////////////////
    } else if([globals.idPrivilegio isEqualToString:@"2"]) {
        ///////  side menu button config   ////////////
        CGRect homeButtonFrame = self.homeButton.frame;
        homeButtonFrame.origin.x = 0;
        homeButtonFrame.origin.y = 0;
        self.homeButton.frame = homeButtonFrame;
        UIView *homelineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, homeButton.frame.size.width, 1)];
        homelineView.backgroundColor = [UIColor lightGrayColor];
        [self.homeButton addSubview:homelineView];
        
        CGRect reportButtonFrame = self.reportButton.frame;
        reportButtonFrame.origin.x = 0;
        reportButtonFrame.origin.y = 60;
        self.reportButton.frame = reportButtonFrame;
        UIView *reportlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, reportButton.frame.size.width, 1)];
        reportlineView.backgroundColor = [UIColor lightGrayColor];
        [self.reportButton addSubview:reportlineView];
        
        CGRect usuarioButtonFrame = self.usuarioButton.frame;
        usuarioButtonFrame.origin.x = 0;
        usuarioButtonFrame.origin.y = 120;
        self.usuarioButton.frame = usuarioButtonFrame;
        UIView *usuariolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, usuarioButton.frame.size.width, 1)];
        usuariolineView.backgroundColor = [UIColor lightGrayColor];
        [self.usuarioButton addSubview:usuariolineView];
        
        CGRect turnoButtonFrame = self.turnoButton.frame;
        turnoButtonFrame.origin.x = 0;
        turnoButtonFrame.origin.y = 180;
        self.turnoButton.frame = turnoButtonFrame;
        UIView *turnolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, turnoButton.frame.size.width, 1)];
        turnolineView.backgroundColor = [UIColor lightGrayColor];
        [self.turnoButton addSubview:turnolineView];
        
        CGRect canceltransactionButtonFrame = self.canceltransactionButton.frame;
        canceltransactionButtonFrame.origin.x = 0;
        canceltransactionButtonFrame.origin.y = 240;
        self.canceltransactionButton.frame = canceltransactionButtonFrame;
        UIView *canceltransactionlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, canceltransactionButton.frame.size.width, 1)];
        canceltransactionlineView.backgroundColor = [UIColor lightGrayColor];
        [self.canceltransactionButton addSubview:canceltransactionlineView];
        
        [self.configButton setHidden:YES];
        [self.newtransactionButton setHidden:YES];
        [self.cerraturnoButton setHidden:YES];
        ///////////////////////////////
        
    } else if([globals.idPrivilegio isEqualToString:@"3"]) {
        ///////  side menu button config   ////////////
        CGRect homeButtonFrame = self.homeButton.frame;
        homeButtonFrame.origin.x = 0;
        homeButtonFrame.origin.y = 0;
        self.homeButton.frame = homeButtonFrame;
        UIView *homelineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, homeButton.frame.size.width, 1)];
        homelineView.backgroundColor = [UIColor lightGrayColor];
        [self.homeButton addSubview:homelineView];
        
        CGRect newtransactionButtonFrame = self.newtransactionButton.frame;
        newtransactionButtonFrame.origin.x = 0;
        newtransactionButtonFrame.origin.y = 60;
        self.newtransactionButton.frame = newtransactionButtonFrame;
        UIView *newtransactiolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, newtransactionButton.frame.size.width, 1)];
        newtransactiolineView.backgroundColor = [UIColor lightGrayColor];
        [self.newtransactionButton addSubview:newtransactiolineView];
        
        CGRect canceltransactionButtonFrame = self.canceltransactionButton.frame;
        canceltransactionButtonFrame.origin.x = 0;
        canceltransactionButtonFrame.origin.y = 120;
        self.canceltransactionButton.frame = canceltransactionButtonFrame;
        UIView *canceltransactionlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, canceltransactionButton.frame.size.width, 1)];
        canceltransactionlineView.backgroundColor = [UIColor lightGrayColor];
        [self.canceltransactionButton addSubview:canceltransactionlineView];
        
        CGRect cerraturnoButtonFrame = self.cerraturnoButton.frame;
        cerraturnoButtonFrame.origin.x = 0;
        cerraturnoButtonFrame.origin.y = 180;
        self.cerraturnoButton.frame = cerraturnoButtonFrame;
        UIView *cerraturnolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, cerraturnoButton.frame.size.width, 1)];
        cerraturnolineView.backgroundColor = [UIColor lightGrayColor];
        [self.cerraturnoButton addSubview:cerraturnolineView];
        
        [self.reportButton setHidden:YES];
        [self.configButton setHidden:YES];
        [self.usuarioButton setHidden:YES];
        [self.turnoButton setHidden:YES];
        
    } else if([globals.idPrivilegio isEqualToString:@"4"]) {
        ///////  side menu button config   ////////////
        CGRect homeButtonFrame = self.homeButton.frame;
        homeButtonFrame.origin.x = 0;
        homeButtonFrame.origin.y = 0;
        self.homeButton.frame = homeButtonFrame;
        UIView *homelineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, homeButton.frame.size.width, 1)];
        homelineView.backgroundColor = [UIColor lightGrayColor];
        [self.homeButton addSubview:homelineView];
        
        CGRect reportButtonFrame = self.reportButton.frame;
        reportButtonFrame.origin.x = 0;
        reportButtonFrame.origin.y = 60;
        self.reportButton.frame = reportButtonFrame;
        UIView *reportlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, reportButton.frame.size.width, 1)];
        reportlineView.backgroundColor = [UIColor lightGrayColor];
        [self.reportButton addSubview:reportlineView];
        
        CGRect configureButtonFrame = self.configButton.frame;
        configureButtonFrame.origin.x = 0;
        configureButtonFrame.origin.y = 120;
        self.configButton.frame = configureButtonFrame;
        UIView *configurelineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, configButton.frame.size.width, 1)];
        configurelineView.backgroundColor = [UIColor lightGrayColor];
        [self.configButton addSubview:configurelineView];
        
        CGRect usuarioButtonFrame = self.usuarioButton.frame;
        usuarioButtonFrame.origin.x = 0;
        usuarioButtonFrame.origin.y = 180;
        self.usuarioButton.frame = usuarioButtonFrame;
        UIView *usuariolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, usuarioButton.frame.size.width, 1)];
        usuariolineView.backgroundColor = [UIColor lightGrayColor];
        [self.usuarioButton addSubview:usuariolineView];
        
        CGRect turnoButtonFrame = self.turnoButton.frame;
        turnoButtonFrame.origin.x = 0;
        turnoButtonFrame.origin.y = 240;
        self.turnoButton.frame = turnoButtonFrame;
        UIView *turnolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, turnoButton.frame.size.width, 1)];
        turnolineView.backgroundColor = [UIColor lightGrayColor];
        [self.turnoButton addSubview:turnolineView];
        
        CGRect newtransactionButtonFrame = self.newtransactionButton.frame;
        newtransactionButtonFrame.origin.x = 0;
        newtransactionButtonFrame.origin.y = 300;
        self.newtransactionButton.frame = newtransactionButtonFrame;
        UIView *newtransactiolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, newtransactionButton.frame.size.width, 1)];
        newtransactiolineView.backgroundColor = [UIColor lightGrayColor];
        
        CGRect canceltransactionButtonFrame = self.canceltransactionButton.frame;
        canceltransactionButtonFrame.origin.x = 0;
        canceltransactionButtonFrame.origin.y = 360;
        self.canceltransactionButton.frame = canceltransactionButtonFrame;
        UIView *canceltransactionlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, canceltransactionButton.frame.size.width, 1)];
        canceltransactionlineView.backgroundColor = [UIColor lightGrayColor];
        [self.canceltransactionButton addSubview:canceltransactionlineView];
        
        CGRect cerraturnoButtonFrame = self.cerraturnoButton.frame;
        cerraturnoButtonFrame.origin.x = 0;
        cerraturnoButtonFrame.origin.y = 420;
        self.cerraturnoButton.frame = cerraturnoButtonFrame;
        UIView *cerraturnolineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, cerraturnoButton.frame.size.width, 1)];
        cerraturnolineView.backgroundColor = [UIColor lightGrayColor];
        [self.cerraturnoButton addSubview:cerraturnolineView];
        
        [self.newtransactionButton addSubview:newtransactiolineView];
    }
    
    
    ////////   get transactions  /////////
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *credentials = @{
                                  @"uid": globals.login_uid,
                                  @"wsk": globals.login_wsk,
                                  @"ambiente": globals.ambiente
                                  };
    NSDictionary *terminal = @{
                               @"branch_office_id": globals.branchid,
                               @"terminal_id": globals.terminalid
                               };

    NSError *error;
    NSData *credentialsPostData = [NSJSONSerialization dataWithJSONObject:credentials options:0 error:&error];
    NSString *credentialsString = [[NSString alloc]initWithData:credentialsPostData encoding:NSUTF8StringEncoding];
    
    NSData *terminalPostData = [NSJSONSerialization dataWithJSONObject:terminal options:0 error:&error];
    NSString *terminalString = [[NSString alloc]initWithData:terminalPostData encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{
                                 @"method": @"get_terminal_transactions_by_shift_mobil",
                                 @"credentials": credentialsString,
                                 @"terminal": terminalString,
                                 @"shift_code": globals.turnoCod,
                                 @"typeReport": @"1"
                                 };
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", nil];
    [sessionManager POST: globals.server_url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        
        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
        
        NSString *xml_string = jsonResponse[@"value"][@"xml_transactions"];
        NSData *xmlData = [xml_string dataUsingEncoding:NSUTF8StringEncoding];
        self.xmlTransactionsParser = [[NSXMLParser alloc] initWithData:xmlData];
        self.xmlTransactionsParser.delegate = self;
        
        [self.xmlTransactionsParser parse];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        } else {
            [self displayAlertView:@"Warning!" :@"Network error."];
        }
        NSLog(@"errororororor");
    }];
    ////////////
}

-(void)setMenuButtonsicon {
    Global *globals = [Global sharedInstance];
    if(globals.selected_language == 0) {
        [self.homeButton setImage:[UIImage imageNamed: @"menu_home_sp"] forState:UIControlStateNormal];
        [self.reportButton setImage:[UIImage imageNamed: @"menu_reports_sp"] forState:UIControlStateNormal];
        [self.configButton setImage:[UIImage imageNamed: @"menu_configuration_sp"] forState:UIControlStateNormal];
        [self.usuarioButton setImage:[UIImage imageNamed: @"menu_users_sp"] forState:UIControlStateNormal];
        [self.turnoButton setImage:[UIImage imageNamed: @"menu_shift_sp"] forState:UIControlStateNormal];
        [self.canceltransactionButton setImage:[UIImage imageNamed: @"menu_canceltransaction_sp"] forState:UIControlStateNormal];
        [self.newtransactionButton setImage:[UIImage imageNamed: @"menu_newtransaction_sp"] forState:UIControlStateNormal];
        [self.logoutButton setImage:[UIImage imageNamed: @"menu_signout_sp"] forState:UIControlStateNormal];
        [self.cerraturnoButton setImage:[UIImage imageNamed: @"menu_close_shift_sp"] forState:UIControlStateNormal];
    } else {
        [self.homeButton setImage:[UIImage imageNamed: @"menu_home_en"] forState:UIControlStateNormal];
        [self.reportButton setImage:[UIImage imageNamed: @"menu_reports_en"] forState:UIControlStateNormal];
        [self.configButton setImage:[UIImage imageNamed: @"menu_configuration_en"] forState:UIControlStateNormal];
        [self.usuarioButton setImage:[UIImage imageNamed: @"menu_users_en"] forState:UIControlStateNormal];
        [self.turnoButton setImage:[UIImage imageNamed: @"menu_shift_en"] forState:UIControlStateNormal];
        [self.canceltransactionButton setImage:[UIImage imageNamed: @"menu_canceltransaction_en"] forState:UIControlStateNormal];
        [self.newtransactionButton setImage:[UIImage imageNamed: @"menu_newtransaction_en"] forState:UIControlStateNormal];
        [self.logoutButton setImage:[UIImage imageNamed: @"menu_signout_en"] forState:UIControlStateNormal];
        [self.cerraturnoButton setImage:[UIImage imageNamed: @"menu_close_shift_en"] forState:UIControlStateNormal];
    }
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(void)hideSidePanel:(UIGestureRecognizer *)gesture{
    if(![self.canceltransactionAlertView isHidden]) {
        [self.view endEditing:YES];
    }else {
        if (gesture.state == UIGestureRecognizerStateEnded) {
            
            [TransV setHidden:YES];
            [UIView transitionWithView:SidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                CGRect frame = self->SidePanel.frame;
                frame.origin.x = -self->SidePanel.frame.size.width;
                self->SidePanel.frame = frame;
                
            } completion:nil];
        }
    }
    
}

bool xmlTerminal_transaction = false;
bool xmlTransaction = false;
bool xmlTransaction_status = false;
bool xmlTransaction_token = false;
bool xmlTransaction_ern = false;
bool xmlTransaction_amount = false;
bool xmlTransaction_datetime = false;
bool xmlTransaction_reference = false;
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if([elementName isEqualToString:@"terminal_transactions"]) {
        xmlTerminal_transaction = true;
    }
    if(xmlTerminal_transaction && [elementName isEqualToString:@"transaction"]) {
        xmlTransaction = true;
    }
    if(xmlTransaction && [elementName isEqualToString:@"transaction_status"]) {
        xmlTransaction_status = true;
    }
    if(xmlTransaction && [elementName isEqualToString:@"transaction_token"]) {
        xmlTransaction_token = true;
    }
    if(xmlTransaction && [elementName isEqualToString:@"transaction_ern"]) {
        xmlTransaction_ern = true;
    }
    if(xmlTransaction && [elementName isEqualToString:@"transaction_amount"]) {
        xmlTransaction_amount = true;
    }
    if(xmlTransaction && [elementName isEqualToString:@"transaction_datetime"]) {
        xmlTransaction_datetime = true;
    }
    if(xmlTransaction && [elementName isEqualToString:@"transaction_reference"]) {
        xmlTransaction_reference = true;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"terminal_transactions"]) {
        [self.transactionTableView reloadData];
    }
    if([elementName isEqualToString:@"transaction"]) {
        self.transaction = [[NSArray alloc] init];
        self.transaction = @[self.transaction_status, self.transaction_token, self.transaction_ern, self.transaction_amount, self.transaction_datetime, self.transaction_reference];
        [self.transactionArray addObject:self.transaction];
        xmlTransaction = false;
    }
    if([elementName isEqualToString:@"transaction_status"]) {
        xmlTransaction_status = false;
    }
    if([elementName isEqualToString:@"transaction_token"]) {
        xmlTransaction_token = false;
    }
    if([elementName isEqualToString:@"transaction_ern"]) {
        xmlTransaction_ern = false;
    }
    if([elementName isEqualToString:@"transaction_amount"]) {
        xmlTransaction_amount = false;
    }
    if([elementName isEqualToString:@"transaction_datetime"]) {
        xmlTransaction_datetime = false;
    }
    if([elementName isEqualToString:@"transaction_reference"]) {
        xmlTransaction_reference = false;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if(xmlTransaction && xmlTransaction_status) {
        self.transaction_status = string;
    }
    if(xmlTransaction && xmlTransaction_token) {
        self.transaction_token = string;
    }
    if(xmlTransaction && xmlTransaction_ern) {
        self.transaction_ern = string;
    }
    if(xmlTransaction && xmlTransaction_amount) {
        self.transaction_amount = string;
    }
    if(xmlTransaction && xmlTransaction_datetime) {
        self.transaction_datetime = string;
    }
    if(xmlTransaction && xmlTransaction_reference) {
        self.transaction_reference = string;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Global *globals = [Global sharedInstance];
    CancelTransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[CancelTransactionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *amountLabelText = [NSString stringWithFormat:@"$%@", self.transactionArray[indexPath.row][3]];
    cell.transaction_amountLabel.text = amountLabelText;
    cell.transaction_ernLabel.text = self.transactionArray[indexPath.row][2];
    cell.transaction_datetimeLabel.text = self.transactionArray[indexPath.row][4];
    cell.transaction_referenceLabel.text = self.transactionArray[indexPath.row][5];
    cell.transaction_statusLabel.text = self.transactionArray[indexPath.row][0];
    if(globals.selected_language == 0) {
        cell.amountcommentLabel.text = @"Monto Total:";
        cell.erncommentLabel.text = @"ERN:";
        cell.fechacommentLabel.text = @"Fecha:";
        cell.referencecommentLabel.text = @"Referncia de pago:";
        cell.statuscommentLabel.text = @"Estado:";
    } else {
        cell.amountcommentLabel.text = @"Amount Charged:";
        cell.erncommentLabel.text = @"ERN:";
        cell.fechacommentLabel.text = @"Date:";
        cell.referencecommentLabel.text = @"Pay Reference:";
        cell.statuscommentLabel.text = @"Status:";
    }
    
    [cell setSelected_index:indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void) reloadCancelTransactionTableViewData:(CancelTransactionTableViewCell *)sender :(NSInteger)index {
    NSLog(@"0000:  %lu", (unsigned long)self.transactionArray.count);
    self.canceled_transaction = self.transactionArray[index];
    self.canceled_index = index;
    [self.transactionArray removeObjectAtIndex:index];
    [self.transactionTableView reloadData];
    NSLog(@"1111:  %lu", (unsigned long)self.transactionArray.count);
    
    Global *globals = [Global sharedInstance];
    if(globals.selected_language == 0) {
        self.alertTitleLabel.text = [NSString stringWithFormat:@"¿Seguro que deseas anular la transacción %@?", self.canceled_transaction[5]];
    } else {
        self.alertTitleLabel.text = [NSString stringWithFormat:@"Are you sure want to cancel transaction %@?", self.canceled_transaction[5]];
    }
    [self.TransV setHidden:NO];
    [self.canceltransactionAlertView setHidden:NO];
}

- (IBAction)menuButtonAction:(id)sender {
    if(![self.canceltransactionAlertView isHidden]) {
        [self.canceltransactionAlertView setHidden:YES];
        [self.TransV setHidden:YES];
    }
    if([TransV isHidden]) {
        [TransV setHidden:NO];
        [UIView transitionWithView:SidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect frame = self->SidePanel.frame;
            frame.origin.x = 0;
            self->SidePanel.frame = frame;
            
        } completion:nil];
    } else {
        [TransV setHidden:YES];
        [UIView transitionWithView:SidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect frame = self->SidePanel.frame;
            frame.origin.x = -self->SidePanel.frame.size.width;
            self->SidePanel.frame = frame;
            
        } completion:nil];
    }
}

- (IBAction)menucanceltransactionButtonAction:(id)sender {
    [TransV setHidden:YES];
    [UIView transitionWithView:SidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = self->SidePanel.frame;
        frame.origin.x = -self->SidePanel.frame.size.width;
        self->SidePanel.frame = frame;
        
    } completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"canceltransactiontowelcome_segue"]) {
        WelcomeViewController *WelcomeVC;
        WelcomeVC = [segue destinationViewController];
    }
}

- (IBAction)menusignoutButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"canceltransactiontowelcome_segue" sender:self];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
    [self.transactionTableView reloadData];
    [self.TransV setHidden:YES];
    [self.canceltransactionAlertView setHidden:YES];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (IBAction)removeButtonAction:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *reasontext = self.reasonTextField.text;
    
    Global *globals = [Global sharedInstance];
    
    if([email isEqualToString:@""]) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingrese Email."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input email."];
        }
        return;
    }
    if([reasontext isEqualToString:@""]) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingrese razón"];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input reason"];
        }
        return;
    }
    if(![self validateEmailWithString:email]) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor utilice la dirección de correo electrónico válida."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please use valid email address."];
        }
        return;
    }
    
    [self.TransV setHidden:YES];
    [self.canceltransactionAlertView setHidden:YES];
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *credentials = @{
                                  @"uid": globals.login_uid,
                                  @"wsk": globals.login_wsk,
                                  @"ambiente": globals.ambiente
                                  };

    NSError *error;
    NSData *credentialsPostData = [NSJSONSerialization dataWithJSONObject:credentials options:0 error:&error];
    NSString *credentialsString = [[NSString alloc]initWithData:credentialsPostData encoding:NSUTF8StringEncoding];
  
    NSDictionary *parameters = @{
                                 @"method": @"void_transaction_mobil",
                                 @"credentials": credentialsString,
                                 @"void_reason": reasontext,
                                 @"transaction_reference": self.canceled_transaction[5]
                                 };
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", nil];
    [sessionManager POST: globals.server_url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        
        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
        if([jsonResponse[@"code"] isEqualToString:@"PG1021"]) {
            self.dataTransaction = jsonResponse;
            [self.dataTransaction setValue:globals.nombreComercio forKey:@"comercio"];
            [self.dataTransaction setValue:globals.moneda forKey:@"moneda"];
            [self.dataTransaction setValue:self.emailTextField.text forKey:@"mail_comprador"];
            [self.dataTransaction setValue:globals.emailComercio forKey:@"emailComercio"];
            
            NSLog(@"000000::: %@", self.dataTransaction);
            
            [self insertTransactions:jsonResponse :reasontext];
        } else {
            [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
            [self.transactionTableView reloadData];
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Ocurrió un error. Por favor contacte a soporte."];
            } else {
                [self displayAlertView:@"Warning!" :@"An error has occured. Please contact support."];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
        [self.transactionTableView reloadData];
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        } else {
            [self displayAlertView:@"Warning!" :@"Network error."];
        }
    }];
}

- (IBAction)cerraturnoButtonAction:(id)sender {
    Global *globals = [Global sharedInstance];
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *param = @{@"param": @{
                                    @"idUser": globals.idUser,
                                    @"turnoCod": globals.turnoCod,
                                    }};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
    NSString *string = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameters = @{
                                 @"method": @"closeShift",
                                 @"param": string
                                 };
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", nil];
    [sessionManager POST: globals.server_url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        
        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
        BOOL status = [jsonResponse[@"status"] boolValue];
        if(status) {
            [self performSegueWithIdentifier:@"canceltransactiontowelcome_segue" sender:self];
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Ocurrió un error. Por favor contacte a soporte."];
            } else {
                [self displayAlertView:@"Warning!" :@"An error has occurred. Please contact support."];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        } else {
            [self displayAlertView:@"Warning!" :@"Network error."];
        }
    }];
}

-(void)insertTransactions:(NSDictionary *)data :(NSString *)void_reason {
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];

    Global *globals = [Global sharedInstance];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"America/El_Salvador"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *fechaDate = [dateFormatter dateFromString:data[@"value"][@"void_origin_transaction_info"][@"date_trans"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fechaString = [dateFormatter stringFromDate:fechaDate];
    
    NSDictionary *insertTransactions = @{
                                  @"total": data[@"value"][@"void_origin_transaction_info"][@"amount"],
                                  @"ern": data[@"value"][@"void_origin_transaction_info"][@"ern"],
                                  @"referencia": data[@"value"][@"void_origin_transaction_info"][@"reference"],
                                  @"fecha": fechaString,
                                  @"status": data[@"value"][@"void_origin_transaction_info"][@"status"],
                                  @"concepto": void_reason,
                                  @"ipPublica": globals.IPAddress,
                                  @"idTurno": globals.idTurno
                                  };

    NSError *error;
    NSData *transactionsPostData = [NSJSONSerialization dataWithJSONObject:insertTransactions options:0 error:&error];
    NSString *transactionsString = [[NSString alloc]initWithData:transactionsPostData encoding:NSUTF8StringEncoding];

    NSDictionary *parameters = @{
                                 @"method": @"insertTransactions",
                                 @"param": transactionsString,
                                 };
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", nil];
    [sessionManager POST: globals.server_url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        
        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
        NSLog(@"wewewewe:   %@", jsonResponse);
        BOOL status = [jsonResponse[@"status"] boolValue];
        if(status) {
            [self generatePDF];
        } else {
            [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
            [self.transactionTableView reloadData];
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Ha ocurrido un error al cancelar la transacción. Por favor contacte a soporte."];
            } else {
                [self displayAlertView:@"Warning!" :@"An error has occurred when canceling transaction. Please contact support."];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
        [self.transactionTableView reloadData];
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        } else {
            [self displayAlertView:@"Warning!" :@"Network error."];
        }
    }];
}

-(void)generatePDF {
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    Global *globals = [Global sharedInstance];
    
    NSDictionary *dataVoidTransaction = self.dataTransaction;
    NSError *error;
    
    NSDictionary *converObject = @{
                                   @"dataTransacction": dataVoidTransaction
                                   };
    
    NSData *dataTransactionData = [NSJSONSerialization dataWithJSONObject:converObject options:0 error:&error];
    NSString *paramString = [[NSString alloc]initWithData:dataTransactionData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameters = @{
                                 @"method": @"generateVoidPDF",
                                 @"param": paramString,
                                 };
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", nil];
    [sessionManager POST: globals.server_url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        
        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
        NSLog(@"2222222:   %@", jsonResponse);
        BOOL status = [jsonResponse[@"status"] boolValue];
        if(status) {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Éxito!" :@"Voucher enviado satisfactoriamente!"];
            } else {
                [self displayAlertView:@"Success!" :@"Voucher sent successfully!"];
            }
        } else {
            [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
            [self.transactionTableView reloadData];
            
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Ha ocurrido un error al cancelar la transacción. Por favor contacte a soporte."];
            } else {
                [self displayAlertView:@"Warning!" :@"An error has occurred when canceling transaction. Please contact support."];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.transactionArray insertObject:self.canceled_transaction atIndex:self.canceled_index];
        [self.transactionTableView reloadData];
        
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        } else {
            [self displayAlertView:@"Warning!" :@"Network error."];
        }
    }];
}

-(void)displayAlertView: (NSString *)header :(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK action");
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
