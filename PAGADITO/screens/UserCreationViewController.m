//
//  UserCreationViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/7.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "UserCreationViewController.h"
#import "LastCommercialInfoViewController.h"
#import "AFNetworking.h"
#import "Global.h"
#import "MultiLanguage.h"

@interface UserCreationViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;


@property(strong, nonatomic)NSMutableArray *role_list;

@property(strong, nonatomic)NSMutableArray *infoUserArray;

@property(strong, nonatomic)NSString *checkStatus;

@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)NSString *lastname;
@property(strong, nonatomic)NSString *username;
@property(strong, nonatomic)NSString *password;
@property(strong, nonatomic)NSString *confirmpassword;
@property(strong, nonatomic)NSString *pin_code;

@property(strong, nonatomic)NSDictionary *infoUserDic;


@end

@implementation UserCreationViewController

@synthesize roleTableView;
@synthesize nameTextField, lastnameTextField, usernameTextField, passwordTextField, confirmpwdTextField;
@synthesize selectRoleButton, continueButton, switchButton, checkBoxUIView, pincodeUIView, pincodeTextField;
@synthesize roleTableViewHeightConstraint;
@synthesize titleLabel, checkboxCommentLabel, pincodeCommentLabel;

int role_int = -1;


- (void)viewDidLoad {
    [super viewDidLoad];
    Global *globals = [Global sharedInstance];
    MultiLanguage *multiLanguage = [MultiLanguage sharedInstance];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    role_int = -1;
    self.checkStatus = @"1";
    self.infoUserArray = [[NSMutableArray alloc] init];
//    self.role_list = [[NSMutableArray alloc] initWithObjects:@"Administrador", @"Administrador Único", nil];
    self.role_list = multiLanguage.usercreationVC_role_list[globals.selected_language];
    
    roleTableViewHeightConstraint.constant = 40 * self.role_list.count;
    
    [roleTableView setHidden:YES];
    [checkBoxUIView setHidden:YES];
    [pincodeUIView setHidden:YES];
    
    /////  multi language configure  ////
    
    self.titleLabel.text = multiLanguage.usercreationVC_titleText[globals.selected_language];
    [self.selectRoleButton setTitle:multiLanguage.usercreationVC_selectRoleButtonText[globals.selected_language] forState:UIControlStateNormal];
    self.checkboxCommentLabel.text = multiLanguage.usercreationVC_checkboxcommentLabelText[globals.selected_language];
    self.pincodeCommentLabel.text = multiLanguage.usercreationVC_pincodecommentLabelText[globals.selected_language];
    self.nameTextField.placeholder = multiLanguage.usercreationVC_firstnameTextFieldPlaceholder[globals.selected_language];
    self.lastnameTextField.placeholder = multiLanguage.usercreationVC_lastTextFieldPlaceholder[globals.selected_language];
    self.usernameTextField.placeholder = multiLanguage.usercreationVC_usernameTextFieldPlaceholder[globals.selected_language];
    self.passwordTextField.placeholder = multiLanguage.usercreationVC_passwordTextFieldPlaceholder[globals.selected_language];
    self.confirmpwdTextField.placeholder = multiLanguage.usercreationVC_confirmTextFieldPlaceholder[globals.selected_language];
    [self.continueButton setTitle:multiLanguage.usercreationVC_continueButtonText[globals.selected_language] forState:UIControlStateNormal];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)continueButtonAction:(id)sender {
    
    Global *globals = [Global sharedInstance];
    MultiLanguage *multiLanguage = [MultiLanguage sharedInstance];
    
    if(role_int == -1) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor seleccione un rol de usuario."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please select one of user role."];
        }
        return;
    }
    NSLog(@"button click role int: %d", role_int);
    self.name = nameTextField.text;
    self.lastname = lastnameTextField.text;
    self.username = usernameTextField.text;
    self.password = passwordTextField.text;
    self.confirmpassword = confirmpwdTextField.text;
    self.pin_code = pincodeTextField.text;
    
    if((self.name.length == 0) || (self.lastname.length == 0) || (self.username.length == 0) || (self.password.length == 0) || (self.confirmpassword.length == 0)) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor llene todos los campos."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please fill all of data."];
        }
        return;
    }
    if(self.password.length < 6) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"La contraseña debe tener al menos 6 caracteres."];
        } else {
            [self displayAlertView:@"Warning!" :@"Password have to be at least 6 characters."];
        }
        return;
    }
    if(![self.password isEqualToString:self.confirmpassword]) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Las contraseñas no coinciden."];
        } else {
            [self displayAlertView:@"Warning!" :@"Password doesn't match."];
        }
        return;
    }
    
    [self startActivityIndicator];
    
    NSDictionary *parameters = @{
                                 @"method": @"checkUserName",
                                 @"username": self.username
                                 };
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", nil];
    [sessionManager POST: globals.server_url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *jsonError;
         NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
         
         [self stopActivityIndicator];
         
         BOOL status = [jsonResponse[@"status"] boolValue];
         
         if(status) {
             if(globals.selected_language == 0) {
                 [self displayAlertView:@"¡Advertencia!" :@"Este nombre de usuario no está disponible. Por favor intente de nuevo con un nombre de usuario diferente."];
             } else {
                 [self displayAlertView:@"Warning!" :@"Username is not available. Please try again with another username."];
             }
         } else {
             if(role_int == 4) {
                 NSDictionary *dataUserDic = @{@"nombres":self.name, @"apellidos":self.lastname, @"idPrivilegio":@"4", @"username":self.username, @"password":self.password, @"shiftEveryday":self.checkStatus, @"codigoAprobacion":@""};
                 [self.infoUserArray addObject:dataUserDic];
                 self.infoUserDic = @{@"infoUsuario":self.infoUserArray};
                 /****************
                  go to next screen with infoUserArray
                  ***************/
                 NSLog(@"%@", dataUserDic);
                 [self performSegueWithIdentifier:@"creationtolast_segue" sender:nil];
             } else if(role_int == 1) {
                 if(globals.selected_language == 0) {
                     [self displayAlertView:@"¡Éxito!" :@"Usuario Guardado Correctamente"];
                 } else {
                     [self displayAlertView:@"Success!" :@"User saved successfuly."];
                 }
                 NSDictionary *dataUserDic = @{@"nombres":self.name, @"apellidos":self.lastname, @"idPrivilegio":@"1", @"username":self.username, @"password":self.password, @"shiftEveryday":@"0", @"codigoAprobacion":@""};
                 [self.infoUserArray addObject:dataUserDic];
                 role_int = 2;
                 [self.selectRoleButton setTitle:@"Supervisor" forState:UIControlStateNormal];
                 self.role_list = [[NSMutableArray alloc] initWithObjects:@"Supervisor", nil];
                 [self.roleTableView reloadData];
                 self.roleTableViewHeightConstraint.constant = 40 * self.role_list.count;
                 [self.pincodeUIView setHidden:NO];
             } else if(role_int == 2) {
                 if(self.pin_code.length > 4) {
                     if(globals.selected_language == 0) {
                         [self displayAlertView:@"¡Advertencia!" :@"El código PIN debe tener un máximo de cuatro caracteres."];
                     } else {
                         [self displayAlertView:@"Warning!" :@"PIN code have to be a maximum of 4 chracters."];
                     }
                     return;
                 }
                 if(globals.selected_language == 0) {
                     [self displayAlertView:@"¡Éxito!" :@"Usuario Guardado Correctamente"];
                 } else {
                     [self displayAlertView:@"Success!" :@"User saved successfuly."];
                 }
                 NSDictionary *dataUserDic = @{@"nombres":self.name, @"apellidos":self.lastname, @"idPrivilegio":@"2", @"username":self.username, @"password":self.password, @"shiftEveryday":@"0", @"codigoAprobacion":self.pin_code};
                 [self.infoUserArray addObject:dataUserDic];
                 role_int = 3;
                 if(globals.selected_language == 0) {
                     [self.selectRoleButton setTitle:@"Cajero" forState:UIControlStateNormal];
                     [self.continueButton setTitle:@"Guardar y continuar" forState:UIControlStateNormal];
                     self.role_list = [[NSMutableArray alloc] initWithObjects:@"Cajero", nil];
                 } else {
                     [self.selectRoleButton setTitle:@"Cashier" forState:UIControlStateNormal];
                     [self.continueButton setTitle:@"Save and Continue" forState:UIControlStateNormal];
                     self.role_list = [[NSMutableArray alloc] initWithObjects:@"Cashier", nil];
                 }
                 [self.roleTableView reloadData];
                 self.roleTableViewHeightConstraint.constant = 40 * self.role_list.count;
                 [self.pincodeUIView setHidden:YES];
                 [self.checkBoxUIView setHidden:NO];
                 [self.switchButton setOn:YES];
                 self.checkStatus = @"1";
             } else if(role_int == 3) {
                 NSDictionary *dataUserDic = @{@"nombres":self.name, @"apellidos":self.lastname, @"idPrivilegio":@"3", @"username":self.username, @"password":self.password, @"shiftEveryday":self.checkStatus, @"codigoAprobacion":@""};
                 [self.infoUserArray addObject:dataUserDic];
                 
                 self.infoUserDic = @{@"infoUsuario":self.infoUserArray};
                 
                 /****************
                  go to next screen with infoUserArray
                  ***************/
                 [self performSegueWithIdentifier:@"creationtolast_segue" sender:nil];
             }
             self.nameTextField.text = @"";
             self.lastnameTextField.text = @"";
             self.usernameTextField.text = @"";
             self.passwordTextField.text = @"";
             self.confirmpwdTextField.text = @"";
         } 
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self stopActivityIndicator];
         if(globals.selected_language == 0) {
             [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
         } else {
             [self displayAlertView:@"Warning!" :@"Network error."];
         }
         
     }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"creationtolast_segue"]) {
        LastCommercialInfoViewController *nextVC = segue.destinationViewController;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        nextVC.infoUsuario = self.infoUserDic;
    }
}

- (IBAction)selectRoleButtonAction:(id)sender {
    if([roleTableView isHidden]) {
        [roleTableView setHidden:NO];
    } else {
        [roleTableView setHidden:YES];
    }
}

- (IBAction)switchAction:(id)sender {
    if(switchButton.on) {
        self.checkStatus = @"1";
    } else {
        self.checkStatus = @"0";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.role_list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"role_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.role_list[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Global *globals = [Global sharedInstance];
    MultiLanguage *multiLanguage = [MultiLanguage sharedInstance];
    [selectRoleButton setTitle:self.role_list[indexPath.row] forState:UIControlStateNormal];
    [roleTableView setHidden:YES];
    if(indexPath.row == 0) {
        if((role_int == -1) || (role_int == 4)) {// select adiministrator
            role_int = 1;
            [continueButton setTitle:multiLanguage.usercreationVC_admincontinueButtonText[globals.selected_language] forState:UIControlStateNormal];
            [checkBoxUIView setHidden:YES];
        }
    } else if(indexPath.row == 1) { // select administrator unico
        role_int = 4;
        [checkBoxUIView setHidden:NO];
        [switchButton setOn:YES];
        self.checkStatus = @"1";
        [continueButton setTitle:multiLanguage.usercreationVC_unicocontinueButtonText[globals.selected_language] forState:UIControlStateNormal];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

//-(void)setHeightOfTableView
//{
//
//    /**** set frame size of tableview according to number of cells ****/
//    CGFloat rowHeight = 40.0f;
//    int tableHeight = rowHeight * self.role_list.count;
////    CGRect tableFrame = self.roleTableView.frame;
////    tableFrame.size.height = tableHeight;
////    self.roleTableView.frame = tableFrame;
//    [self.roleTableView setFrame:(CGRect){roleTableView.frame.origin.x, roleTableView.frame.origin.y, self.roleTableView.frame.size.width, tableHeight}];
//
//}

-(void)displayAlertView: (NSString *)header :(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK action");
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) startActivityIndicator {
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
}

-(void) stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    [self.overlayView removeFromSuperview];
}

@end
