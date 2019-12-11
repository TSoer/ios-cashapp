//
//  AssignShiftViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/18.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "AssignShiftViewController.h"
#import "../tableviewcells/ShiftListTableViewCell.h"
#import "AFNetworking.h"
#import "Global.h"
#import "../SecondViewController.h"
#import "SearchShiftViewController.h"
#import "CloseShiftViewController.h"
#import "ShiftListViewController.h"
#import "UserAdminViewController.h"
#import "WelcomeViewController.h"

@interface AssignShiftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSMutableArray *cashier_array;
@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@property(strong, nonatomic)NSString *selected_cashierUserID;
@property(strong, nonatomic)NSString *selected_cashierUsername;
@property(strong, nonatomic)NSString *shifEveryday;
@property(strong, nonatomic)NSString *sessionInfoLabelText;

@end

@implementation AssignShiftViewController
@synthesize shift_array;
@synthesize TransV, shiftlistTableView, sessionInfoLabel;
@synthesize assignturnoAlertView, selectcashierButton, cashierlistTableView, switchButton, cashierlistTableViewHeightConstraint;
@synthesize completeInsertShiftAlertView;
@synthesize SidePanel, homeButton, reportButton, configButton, usuarioButton, turnoButton, canceltransactionButton, newtransactionButton, logoutButton, cerraturnoButton;
@synthesize titleLabel, searchButtonLabel, assignButtonlabel, closeButtonLabel, codeheadLabel, timedateheadLabel, usernameheadLabel, sessioncommentLabel, assignturnoAlertViewTitleLabel, checkboxcommentLabel, cancelButton, assignButton, completeAlertViewCommentLabel, completeAlertViewContinueButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Global *globals = [Global sharedInstance];

    if(globals.selected_language == 0) {
        self.titleLabel.text = @"Listado de turnos";
        self.closeButtonLabel.text = @"Cerrar";
        self.assignButtonlabel.text = @"Asignar";
        self.searchButtonLabel.text = @"Buscar";
        self.codeheadLabel.text = @"Codigo";
        self.usernameheadLabel.text = @"Usuario";
        self.timedateheadLabel.text = @"Fecha/hora";
        self.sessioncommentLabel.text = @"Sesión iniciada:";
        self.assignturnoAlertViewTitleLabel.text = @"Asignar Turno";
        self.checkboxcommentLabel.text = @"Asignar nuevo turno automaticaments todos los dias.";
        [self.cancelButton setTitle:@"Cancelar" forState:UIControlStateNormal];
        [self.assignButton setTitle:@"Asignar" forState:UIControlStateNormal];
        [self.completeAlertViewContinueButton setTitle:@"Continuar" forState:UIControlStateNormal];
        [selectcashierButton setTitle:@"Seleccione un Cajero" forState:UIControlStateNormal];
    } else {
        self.titleLabel.text = @"Shift List";
        self.closeButtonLabel.text = @"Close";
        self.assignButtonlabel.text = @"Assign";
        self.searchButtonLabel.text = @"Search";
        self.codeheadLabel.text = @"Code";
        self.usernameheadLabel.text = @"Username";
        self.timedateheadLabel.text = @"Time/Date";
        self.sessioncommentLabel.text = @"Session started:";
        self.assignturnoAlertViewTitleLabel.text = @"Assign Shift";
        self.checkboxcommentLabel.text = @"Assign new shift automaticaments every day.";
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.assignButton setTitle:@"Assign" forState:UIControlStateNormal];
        [self.completeAlertViewContinueButton setTitle:@"Continue" forState:UIControlStateNormal];
        [selectcashierButton setTitle:@"Select Cashier" forState:UIControlStateNormal];
    }
    
    [self setMenuButtonsicon];
    
    //session info label
    self.sessionInfoLabelText = [NSString stringWithFormat:@"%@ / %@", globals.username, globals.nombreComercio];
    sessionInfoLabel.text = self.sessionInfoLabelText;
    
    
    self.cashier_array = [[NSMutableArray alloc] init];
    self.selected_cashierUserID = @"";
    self.shifEveryday = @"1";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    
    [self getCashierDisplayView];
    
    ///////////////   side menu buttons configure   /////////////////
    if([globals.idPrivilegio isEqualToString:@"2"]) {
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
    /////////////////////////////////////////////////////
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSidePanel:)];
    tapper.numberOfTapsRequired = 1;
    [TransV addGestureRecognizer:tapper];
    
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

-(void)hideSidePanel:(UIGestureRecognizer *)gesture{
    if([self.assignturnoAlertView isHidden] && [self.completeInsertShiftAlertView isHidden]) {
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

-(void)getCashierDisplayView {
    Global *globals = [Global sharedInstance];
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *infoComercio = @{@"infoComercio": @{
                                           @"idComercio": globals.idComercio,
                                           @"cashier": @"1",
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
        BOOL status = [jsonResponse[@"status"] boolValue];
        if(status) {
            
            NSMutableArray *jsonArray = jsonResponse[@"getUsersPOS"];
            NSArray *cashier = [[NSArray alloc] init];
            for(int i = 0; i < jsonArray.count; i ++) {
                cashier = @[jsonArray[i][@"idUser"], jsonArray[i][@"username"], jsonArray[i][@"removeAt"]];
                [self.cashier_array insertObject:cashier atIndex:i];
            }
            [self.cashierlistTableView reloadData];
            if(self.cashier_array.count * 40 < 100) {
                self.cashierlistTableViewHeightConstraint.constant = self.cashier_array.count * 40;
            } else {
                self.cashierlistTableViewHeightConstraint.constant = 100;
            }
            [self.TransV setHidden:NO];
            [self.assignturnoAlertView setHidden:NO];
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"¡Todos sus cajeros ya poseen asignación de turno automático!"];
            } else {
                [self displayAlertView:@"Warning!" :@"All your ATMs already have automatic shift allocation!"];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == shiftlistTableView) {
        return self.shift_array.count;
    } else {
        return self.cashier_array.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Global *globals = [Global sharedInstance];
    if(tableView == shiftlistTableView) {
        ShiftListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shifttablecell"];
        if(cell == nil) {
            cell = [[ShiftListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shifttablecell"];
        }
        cell.codeShiftLabel.text = self.shift_array[indexPath.row][0];
        if([self.shift_array[indexPath.row][7] isEqualToString:@"0"]) {
            if(globals.selected_language == 0) {
                cell.estadoLabel.text = @"Estado: Cerrado";
            } else {
                cell.estadoLabel.text = @"Status: Closed";
            }
            cell.estadoLabel.backgroundColor = UIColor.grayColor;
        } else {
            if(globals.selected_language == 0) {
                cell.estadoLabel.text = @"Estado: Abierto";
            } else {
                cell.estadoLabel.text = @"Status: Open";
            }
            cell.estadoLabel.backgroundColor = UIColor.greenColor;
        }
        cell.usernameLabel.text = self.shift_array[indexPath.row][2];
        cell.fachaInicioLabel.text = self.shift_array[indexPath.row][5];
        cell.fachaFinLabel.text = self.shift_array[indexPath.row][6];
        
        if(globals.selected_language == 0) {
            cell.fechaInicio_commentLabel.text = @"Inicio:";
            cell.Fin_commentLabel.text = @"Fin:";
        } else {
            cell.fechaInicio_commentLabel.text = @"Start:";
            cell.Fin_commentLabel.text = @"End:";
        }
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cashiertablecell"];
        if(cell == nil) {
            cell = [[ShiftListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cashiertablecell"];
        }
        cell.textLabel.text = self.cashier_array[indexPath.row][1];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == shiftlistTableView) {
        return 100;
    } else {
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.cashierlistTableView) {
        [self.selectcashierButton setTitle:self.cashier_array[indexPath.row][1] forState:UIControlStateNormal];
        self.selected_cashierUserID = self.cashier_array[indexPath.row][0];
        self.selected_cashierUsername = self.cashier_array[indexPath.row][1];
        [self.cashierlistTableView setHidden:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"assignshifttowelcome_segue"]) {
        WelcomeViewController *WelcomeVC;
        WelcomeVC = [segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"assignshifttohome_segue"]) {
        SecondViewController *SecondVC;
        SecondVC = [segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"assignshifttosearchshift_segue"]) {
        SearchShiftViewController *SearchShiftVC;
        SearchShiftVC = [segue destinationViewController];
        SearchShiftVC.shift_array = self.shift_array;
    }
    if([segue.identifier isEqualToString:@"assignshifttocloseshift_segue"]) {
        CloseShiftViewController *CloseShiftVC;
        CloseShiftVC = [segue destinationViewController];
        CloseShiftVC.shift_array = self.shift_array;
    }
    if([segue.identifier isEqualToString:@"assignshifttoshiftlist_segue"]) {
        ShiftListViewController *ShiftListVC;
        ShiftListVC = [segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"assignshifttouseradmin_segue"]) {
        UserAdminViewController *UserAdminVC;
        UserAdminVC = [segue destinationViewController];
    }
}

- (IBAction)selectcashierButtonAction:(id)sender {
    if([self.cashierlistTableView isHidden]) {
        [self.cashierlistTableView setHidden:NO];
    } else {
        [self.cashierlistTableView setHidden:YES];
    }
}

- (IBAction)switchButtonAction:(id)sender {
    if(self.switchButton.on) {
        self.shifEveryday = @"1";
    } else {
        self.shifEveryday = @"0";
    }
}

- (IBAction)assignturnoCancelButtonAction:(id)sender {
    [self.TransV setHidden:YES];
    [self.assignturnoAlertView setHidden:YES];
    self.selected_cashierUserID = @"";
}

- (IBAction)assignturnoOKButtonAction:(id)sender {
    Global *globals = [Global sharedInstance];
    if(self.selected_cashierUserID.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor seleccione un cajero."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please select cashier."];
        }
        return;
    }
    
    [self.TransV setHidden:YES];
    [self.assignturnoAlertView setHidden:YES];
    
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    
    NSDictionary *asignarTurno = @{@"asignarTurno": @{
                                           @"cmbUserAsign": self.selected_cashierUserID,
                                           @"idDispositivo": globals.idDispositivo,
                                           @"idUserSupervisor": globals.idUser,
                                           @"shiftEveryday": self.shifEveryday
                                           }};
    NSLog(@"%@", asignarTurno);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:asignarTurno options:0 error:&error];
    NSString *string = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameters = @{
                                 @"method": @"insertShiftCode",
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
        
        self.selected_cashierUserID = @"";
        NSString *status1 = jsonResponse[@"status1"];
        if([status1 isEqualToString:@"1"]) {
            [self.TransV setHidden:NO];
            if(globals.selected_language == 0) {
                NSString *alertMessage = [NSString stringWithFormat:@"Haz asignado exitosamente un turno a %@?", self.selected_cashierUsername];
                self.completeAlertViewCommentLabel.text = alertMessage;
            } else {
                NSString *alertMessage = [NSString stringWithFormat:@"You have successfully assigned a shift to %@?", self.selected_cashierUsername];
                self.completeAlertViewCommentLabel.text = alertMessage;
            }
            [self.completeInsertShiftAlertView setHidden:NO];
            
        } else if([status1 isEqualToString:@"0"]) {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Ha ocurrido un error. Por favor contacte a soporte."];
            } else {
                [self displayAlertView:@"Warning!" :@"An error has occured. please contact support."];
            }
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"¡Este cajero ya tiene un turno activo!"];
            } else {
                [self displayAlertView:@"Warning!" :@"Cashier already has an active shift!"];
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

- (IBAction)backButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttoshiftlist_segue" sender:self];
}

- (IBAction)menuButtonAction:(id)sender {
    if([self.assignturnoAlertView isHidden] && [self.completeInsertShiftAlertView isHidden]) {
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
}

- (IBAction)mainmenuSearchShiftButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttosearchshift_segue" sender:self];
}

- (IBAction)mainmenuAssignShiftButtonAction:(id)sender {
    Global *globals = [Global sharedInstance];
    self.cashier_array = [[NSMutableArray alloc] init];
    self.selected_cashierUserID = @"";
    if(globals.selected_language == 0) {
        [self.selectcashierButton setTitle:@"Seleccione un Cajero" forState:UIControlStateNormal];
    } else {
        [self.selectcashierButton setTitle:@"Select Cashier" forState:UIControlStateNormal];
    }
    [switchButton setOn:YES];
    [self getCashierDisplayView];
}

- (IBAction)mainmenuCloseShiftButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttocloseshift_segue" sender:self];
}

- (IBAction)completeAlertViewContinueButtonAction:(id)sender {
    [self.TransV setHidden:YES];
    [self.completeInsertShiftAlertView setHidden:YES];
    [self performSegueWithIdentifier:@"assignshifttoshiftlist_segue" sender:self];
}

-(void)displayAlertView: (NSString *)header :(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)homeButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttohome_segue" sender:self];
}

- (IBAction)usuarioButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttouseradmin_segue" sender:self];
}

- (IBAction)turnoButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttoshiftlist_segue" sender:self];
}

- (IBAction)signoutButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"assignshifttowelcome_segue" sender:self];
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
            [self performSegueWithIdentifier:@"assignshifttowelcome_segue" sender:self];
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
@end
