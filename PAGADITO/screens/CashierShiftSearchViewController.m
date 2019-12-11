//
//  CashierShiftSearchViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/23.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "CashierShiftSearchViewController.h"
#import "Global.h"
#import "AFNetworking.h"
#import "WelcomeViewController.h"
#import "../tableviewcells/CashierShiftSearchTableViewCell.h"
#import "CashierShiftSearchResultViewController.h"

@interface CashierShiftSearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSString *sessionInfoLabelText;
@property(strong, nonatomic)NSMutableArray *cashier_array;
@property(nonatomic)NSInteger selected_cashier_index;
@property(strong, nonatomic)NSString *codigoText;

@property(strong, nonatomic)NSString *startDateString;
@property(strong, nonatomic)NSString *closeDateString;

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@end

@implementation CashierShiftSearchViewController
@synthesize incioDateString, cierreDateString, shift_code, selected_cashier;
@synthesize TransV, SidePanel, sessionInfoLabel, cashierTableView, selectcashierButton, codigoTextView, startDatePicker, closeDatePicker;
@synthesize homeButton, reportButton, configButton, usuarioButton, turnoButton, canceltransactionButton, newtransactionButton, logoutButton, cerraturnoButton;
@synthesize titleLabel, maincommentLabel, startdatecommentLabel, enddatecommentLabel, codecommentLabel, cashiercommentLabel, searchButton, sessioncommentLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Global *globals = [Global sharedInstance];
    
    ///  init   //////
    self.cashier_array = [[NSMutableArray alloc] init];
    self.selected_cashier_index = 0;
    
    if(incioDateString != nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *nstartDate = [dateFormatter dateFromString:incioDateString];
        [self.startDatePicker setDate:nstartDate];
        
        self.startDateString = incioDateString;
        NSLog(@"get string111:  %@", incioDateString);
    }
//    else {
//        NSDate *currentDate = [NSDate date];
//        [startDatePicker setDate:currentDate];
//    }
    
    if(cierreDateString != nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *ncloseDate = [dateFormatter dateFromString:cierreDateString];
        [self.closeDatePicker setDate:ncloseDate];
        
        self.closeDateString = cierreDateString;
        NSLog(@"get string222:  %@", cierreDateString);
    }
//    else {
//        NSDate *currentDate = [NSDate date];
//        [startDatePicker setDate:currentDate];
//    }
    
    if(shift_code != nil) {
        self.codigoTextView.text = shift_code;
        self.codigoText = shift_code;
    }
    
    
//    globals.selected_language = 0;
    if(globals.selected_language == 0) {
        self.titleLabel.text = @"Turno de cajeros";
        self.maincommentLabel.text = @"Buscar Turnos";
        self.startdatecommentLabel.text = @"Fecha de inicio:";
        self.enddatecommentLabel.text = @"Fecha de cierre:";
        self.codecommentLabel.text = @"Código:";
        self.codigoTextView.placeholder = @"Escriba el código";
        self.cashiercommentLabel.text = @"Cajero:";
        [self.selectcashierButton setTitle:@"Seleccionar cajero" forState:UIControlStateNormal];
        [self.searchButton setTitle:@"Buscar" forState:UIControlStateNormal];
        self.sessioncommentLabel.text = @"Sesión iniciada:";
    } else {
        self.titleLabel.text = @"Search Cashier Shift";
        self.maincommentLabel.text = @"Search Shift";
        self.startdatecommentLabel.text = @"Start date:";
        self.enddatecommentLabel.text = @"End date:";
        self.codecommentLabel.text = @"Shift code:";
        self.codigoTextView.placeholder = @"Write the code";
        self.cashiercommentLabel.text = @"Cashier:";
        [self.selectcashierButton setTitle:@"Select cashier" forState:UIControlStateNormal];
        [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
        self.sessioncommentLabel.text = @"Session started:";
    }
    
    [self setMenuButtonsicon];
    
    ////  dismiss keyboard   //////
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    /////////  TransV  tanp event   /////////
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSidePanel:)];
    tapper.numberOfTapsRequired = 1;
    [TransV addGestureRecognizer:tapper];
    
    //session info label
    self.sessionInfoLabelText = [NSString stringWithFormat:@"%@ / %@", globals.username, globals.nombreComercio];
    sessionInfoLabel.text = self.sessionInfoLabelText;
    
    //////////// init for activity indicator  /////////
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    
    ///// set side menu buttons
    if([globals.idPrivilegio isEqualToString:@"1"]) {
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
        
        [self.configButton setHidden:YES];
        [self.newtransactionButton setHidden:YES];
        [self.canceltransactionButton setHidden:YES];
        [self.cerraturnoButton setHidden:YES];
        
    } else if([globals.idPrivilegio isEqualToString:@"4"]) {
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
    
    /////////  get user pos  ////////
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *infoComercio = @{@"infoComercio": @{
                                        @"idComercio": globals.idComercio,
                                        }};
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:infoComercio options:0 error:&error];
    NSString *string = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{
                                 @"method": @"getUsersPOS",
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
        
        Boolean status = [jsonResponse[@"status"] boolValue];
        if(status) {
            NSMutableArray *jsonArray = jsonResponse[@"getUsersPOS"];
            NSArray *cashier = [[NSArray alloc] init];
            
            if(jsonArray.count > 0) {
                for(int i = 0; i < jsonArray.count; i ++) {
                    cashier = @[jsonArray[i][@"idUser"], jsonArray[i][@"username"], jsonArray[i][@"removeAt"]];
                    [self.cashier_array insertObject: cashier atIndex: i];
                }
                if(globals.selected_language == 0) {
                    cashier = @[@"-1", @"No Seleccionar", @"1"];
                } else {
                    cashier = @[@"-1", @"No Select", @"1"];
                }
                [self.cashier_array insertObject:cashier atIndex:0];
                [self.cashierTableView reloadData];
                
                if(self->selected_cashier != nil) {
                    if([self->selected_cashier isEqualToString:@""]) {
                        self.selected_cashier_index = 0;
                        [self.selectcashierButton setTitle:self.cashier_array[0][1] forState:UIControlStateNormal];
                        
                    } else {
                        for(int i = 0; i < self.cashier_array.count; i ++) {
                            if([self.cashier_array[i][0] isEqualToString:self->selected_cashier]) {
                                self.selected_cashier_index = i;
                                [self.selectcashierButton setTitle:self.cashier_array[i][1] forState:UIControlStateNormal];
                                break;
                            }
                        }
                    }
                }
                
            } else {
                if(globals.selected_language == 0) {
                    [self displayAlertView:@"¡Advertencia!" :@"No existen turnos."];
                } else {
                    [self displayAlertView:@"Warning!" :@"There is no shifts."];
                }
            }
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!!" :@"Ocurrió un error. Por favor contacte a soporte."];
            } else {
                [self displayAlertView:@"Warning!" :@"An error occured. Please contact support."];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"Warning!" :@"Network error."];
        } else {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        }
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
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [TransV setHidden:YES];
        [UIView transitionWithView:SidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect frame = self->SidePanel.frame;
            frame.origin.x = -self->SidePanel.frame.size.width;
            self->SidePanel.frame = frame;
            
        } completion:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"cahiershiftsearchtowelcome_segue"]) {
        WelcomeViewController *WelcomeVC;
        WelcomeVC = [segue destinationViewController];
    } else if([segue.identifier isEqualToString:@"cashiershiftsearchtocashiershiftsearchresult_segue"]) {
        CashierShiftSearchResultViewController *CashierShiftSearchResultVC;
        CashierShiftSearchResultVC = [segue destinationViewController];
        CashierShiftSearchResultVC.fecha_inicio = self.startDateString;
        CashierShiftSearchResultVC.fecha_fin = self.closeDateString;
        if(self.selected_cashier_index == 0) {
            CashierShiftSearchResultVC.userCajero = @"";
        } else {
            CashierShiftSearchResultVC.userCajero = self.cashier_array[self.selected_cashier_index][0];
        }
        CashierShiftSearchResultVC.codeShift = self.codigoText;
            
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cashier_array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashierShiftSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cashiershifttableviewcell"];
    if(cell == nil) {
        cell = [[CashierShiftSearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cashiershifttableviewcell"];
    }
    cell.usernameLabel.text = self.cashier_array[indexPath.row][1];
    if([self.cashier_array[indexPath.row][2] isEqualToString:@"1"]) {
        [cell.closestatusImageView setHidden:NO];
    } else {
        [cell.closestatusImageView setHidden:YES];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selected_cashier_index = indexPath.row;
    [selectcashierButton setTitle:self.cashier_array[indexPath.row][1] forState:UIControlStateNormal];
    [self.cashierTableView setHidden:YES];
}

- (IBAction)menuButtonAction:(id)sender {
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

- (IBAction)selectcashierButtonAction:(id)sender {
    if(self.cashier_array.count > 0) {
        if([self.cashierTableView isHidden]) {
            [self.cashierTableView setHidden:NO];
        } else {
            [self.cashierTableView setHidden:YES];
        }
    }
}

- (IBAction)signoutButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"cahiershiftsearchtowelcome_segue" sender:self];
}

- (IBAction)searchButtonAction:(id)sender {
    Global *globals = [Global sharedInstance];
    self.codigoText = self.codigoTextView.text;
    if(self.codigoText.length > 10) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"El código debe tener menos de 10 caracteres."];
        } else {
            [self displayAlertView:@"Warning!" :@"Code have to be less than 10 characters."];
        }
        return;
    }
//    NSLocale *locale = [NSLocale currentLocale];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_SV"];
//    self.startDatePicker.locale = locale;
    NSDate *startDate = [self.startDatePicker date];
    NSDate *closeDate = [self.closeDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.startDateString = [dateFormatter stringFromDate:startDate];
    self.closeDateString = [dateFormatter stringFromDate:closeDate];
    
    [self performSegueWithIdentifier:@"cashiershiftsearchtocashiershiftsearchresult_segue" sender:self];
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
            [self performSegueWithIdentifier:@"cahiershiftsearchtowelcome_segue" sender:self];
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



-(void)displayAlertView: (NSString *)header :(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"");
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
