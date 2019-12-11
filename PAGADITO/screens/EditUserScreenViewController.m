//
//  EditUserScreenViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/14.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "EditUserScreenViewController.h"
#import "EditUserViewController.h"
#import "AFNetworking.h"
#import "Global.h"
#import "UserAdminViewController.h"

@interface EditUserScreenViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic)NSMutableArray *selected_user;
@property(strong, nonatomic)NSMutableArray *roleTableArray;
@property(strong, nonatomic)NSString *shiftEveryday;
@property(strong, nonatomic)NSString *firstname_text;
@property(strong, nonatomic)NSString *lastname_text;
@property(strong, nonatomic)NSString *usertname_text;
@property(strong, nonatomic)NSString *password_text;
@property(strong, nonatomic)NSString *confirm_text;
@property(strong, nonatomic)NSString *pincode_text;

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@end

@implementation EditUserScreenViewController
@synthesize user_array, selected_index;
@synthesize roleSelectButton, switchButton, checkBoxUIView, pincodeUIView, roleTableView, roleTableViewHeightConstraint;
@synthesize firstnameTextView, lastnameTextView, usernameTextView, passwordTextView, confirmTextView, pincodeTextView;
@synthesize titleLabel, pincodecommentLabel, checkboxcommentLabel, saveButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Global *globals = [Global sharedInstance];
    if(globals.selected_language == 0) {
        self.titleLabel.text = @"Editar Usuario";
        [self.roleSelectButton setTitle:@"Selecciona un rol de usuario" forState:UIControlStateNormal];
        self.pincodecommentLabel.text = @"PIN de autorización:";
        self.checkboxcommentLabel.text = @"Asignar nuevo turno automaticamente todos los días.";
        self.firstnameTextView.placeholder = @"Nombres";
        self.lastnameTextView.placeholder = @"Apellidos";
        self.usernameTextView.placeholder = @"Usuario";
        self.passwordTextView.placeholder = @"Contraseña";
        self.confirmTextView.placeholder = @"Repetir Contraseña";
        [self.saveButton setTitle:@"Guardar y Continuar" forState:UIControlStateNormal];
    } else {
        self.titleLabel.text = @"Edit User";
        [self.roleSelectButton setTitle:@"Select User Priviledges" forState:UIControlStateNormal];
        self.pincodecommentLabel.text = @"Authorization PIN:";
        self.checkboxcommentLabel.text = @"Automatically assign shift every day.";
        self.firstnameTextView.placeholder = @"First Name";
        self.lastnameTextView.placeholder = @"Last Name";
        self.usernameTextView.placeholder = @"Username";
        self.passwordTextView.placeholder = @"Password";
        self.confirmTextView.placeholder = @"Confirm Password";
        [self.saveButton setTitle:@"Save and Continue" forState:UIControlStateNormal];
    }
    
    ////  dismiss keyboard   //////
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    
    self.selected_user = self.user_array[selected_index];
//    NSLog(@"%@", self.user_array);
    NSLog(@"%@", self.selected_user);
    if([self.selected_user[3] isEqualToString:@"Supervisor"]) {
        self.roleTableArray = [[NSMutableArray alloc] initWithObjects:@"Supervisor", nil];
        [self.checkBoxUIView setHidden:YES];
        [self.pincodeUIView setHidden:NO];
        self.shiftEveryday = @"0";
//        self.pincodeTextView.text = self.selected_user[6];
    } else if([self.selected_user[3] isEqualToString:@"Cajero"]) {
        if(globals.selected_language == 0) {
            self.roleTableArray = [[NSMutableArray alloc] initWithObjects:@"Cajero", nil];
        } else {
            self.roleTableArray = [[NSMutableArray alloc] initWithObjects:@"Cashier", nil];
        }
        if([globals.idPrivilegio isEqualToString:@"1"] || [globals.idPrivilegio isEqualToString:@"4"]) {
            [self.checkBoxUIView setHidden:YES];
            [self.pincodeUIView setHidden:YES];
            self.shiftEveryday = @"1";
        } else {
            [self.checkBoxUIView setHidden:YES];
            [self.pincodeUIView setHidden:YES];
            self.shiftEveryday = @"0";
        }
    }
    [self.roleSelectButton setTitle:self.roleTableArray[0] forState:UIControlStateNormal];
    [self.roleTableView setHidden:YES];
    firstnameTextView.text = self.selected_user[1];
    lastnameTextView.text = self.selected_user[2];
    usernameTextView.text = self.selected_user[4];
    
    ////////////  activity indicator     /////////////
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)backButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"editscreentoedituser_segue" sender:self];
}

- (IBAction)roleSelectButtonAction:(id)sender {
    if([self.roleTableView isHidden]) {
        [self.roleTableView setHidden:NO];
    } else {
        [self.roleTableView setHidden:YES];
    }
}

- (IBAction)switchViewAction:(id)sender {
    if(switchButton.on) {
        self.shiftEveryday = @"1";
    } else {
        self.shiftEveryday = @"0";
    }
}

- (IBAction)SaveandContinueButtonAction:(id)sender {
    self.firstname_text = firstnameTextView.text;
    self.lastname_text = lastnameTextView.text;
    self.usertname_text = usernameTextView.text;
    self.password_text = passwordTextView.text;
    self.pincode_text = pincodeTextView.text;
    self.confirm_text = confirmTextView.text;
    
    Global *globals = [Global sharedInstance];
    
    if(self.firstname_text.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingrese su nombre" :@"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input First Name." :@"nil"];
        }
        return;
    }
    if(self.lastname_text.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingrese su apellido." :@"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input Last Name." :@"nil"];
        }
        return;
    }
    if(self.usertname_text.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingrese su nombre de usuario." :@"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input Username." :@"nil"];
        }
        return;
    }
    if(self.password_text.length < 6) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"La contraseña debe tener al menos 6 caracteres." :@"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Password have to be at least 6 characters" :@"nil"];
        }
        return;
    }
    if(![self.password_text isEqualToString:self.confirm_text]) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Las contraseñas no coinciden." :@"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Password doesn't match." :@"nil"];
        }
        return;
    }
    if([self.selected_user[3] isEqualToString:@"Supervisor"]) {
        if(self.pincode_text.length != 4) {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"El código pin debe tener 4 dígitos." :@"nil"];
            } else {
                [self displayAlertView:@"Warning!" :@"Pin code have to be 4 digits." :@"nil"];
            }
            return;
        }
    }
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    
    NSDictionary *editUser = @{@"editUser": @{
                                          @"nombres":self.firstname_text,
                                          @"apellidos": self.lastname_text,
                                          @"username": self.usertname_text,
                                          @"password": self.password_text,
                                          @"idDispositivo": globals.idDispositivo,
                                          @"idUser": self.selected_user[0],
                                          @"shiftEveryday": @"0",
                                          @"codigoAprobacion": self.pincode_text
                                          }};
    NSLog(@"%@", editUser);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:editUser options:0 error:&error];
    NSString *string = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameters = @{
                                 @"method": @"editSystemUsers",
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
        NSLog(@"%@", jsonResponse);
        BOOL status = [jsonResponse[@"status"] boolValue];
        if(status) {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Éxito!" :@"Usuario editado exitosamente." :@"user_admin"];
            } else {
                [self displayAlertView:@"Congratulations!" :@"The user edited succesfully." :@"user_admin"];
            }
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Ha ocurrido un error al editar el usuario." :@"nil"];
            } else {
                [self displayAlertView:@"Warning!" :@"There has been an error editing the user." :@"nil"];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red." :@"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Network error." :@"nil"];
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"editscreentoedituser_segue"]) {
        EditUserViewController *EditUserVC;
        EditUserVC = [segue destinationViewController];
        EditUserVC.user_array = self.user_array;
    } else if([segue.identifier isEqualToString:@"editscreentouseradmin_segue"]) {
        UserAdminViewController *UserAdminVC;
        UserAdminVC = [segue destinationViewController];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.roleTableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"role_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.roleTableArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.roleSelectButton setTitle:self.roleTableArray[indexPath.row] forState:UIControlStateNormal];
    [self.roleTableView setHidden:YES];
}

-(void)displayAlertView: (NSString *)header :(NSString *)message :(NSString *)nextScreen {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([nextScreen isEqualToString:@"user_admin"]) {
            [self performSegueWithIdentifier:@"editscreentouseradmin_segue" sender:self];
        }
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
