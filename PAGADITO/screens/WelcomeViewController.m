//
//  WelcomeViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/8.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Global.h"
#import "AFNetworking.h"
#import "../SecondViewController.h"

@interface WelcomeViewController ()

@property(strong, nonatomic)NSString *username;
@property(strong, nonatomic)NSString *password;

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@end

@implementation WelcomeViewController

@synthesize logoImageView;
@synthesize usernameTextField, passwordTextField;
@synthesize titleLabel, appnameLabel, signinButton, forgetpasswordButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    Global *globals = [Global sharedInstance];
    if(globals.logo_imagePath.length == 0 ) {
        logoImageView.image = [UIImage imageNamed:@"pagadito_0000_logo.png"];
    } else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isFileExist = [fileManager fileExistsAtPath:globals.logo_imagePath];
        UIImage *logo_image;
        if(isFileExist) {
            logo_image = [[UIImage alloc] initWithContentsOfFile:globals.logo_imagePath];
            logoImageView.image = logo_image;
        } else {
            logoImageView.image = [UIImage imageNamed:@"pagadito_0000_logo.png"];
        }
    }
    self.username = @"";
    self.password = @"";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    
    if(globals.selected_language == 0) {
        self.titleLabel.text = @"¡Bienvenido!";
        self.appnameLabel.text = @"Pagadito POS APP";
        self.usernameTextField.placeholder = @"Usuario";
        self.passwordTextField.placeholder = @"Contraseña";
        [self.signinButton setTitle:@"Inicia sesión" forState:UIControlStateNormal];
        [self.forgetpasswordButton setTitle:@"Olvidé mi contraseña" forState:UIControlStateNormal];
    } else {
        self.titleLabel.text = @"Welcome!";
        self.appnameLabel.text = @"Pagadito POS APP";
        self.usernameTextField.placeholder = @"Username";
        self.passwordTextField.placeholder = @"Password";
        [self.signinButton setTitle:@"Sign In" forState:UIControlStateNormal];
        [self.forgetpasswordButton setTitle:@"Forgot password" forState:UIControlStateNormal];
    }

}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)SigninButtonAction:(id)sender {
    self.username = usernameTextField.text;
    self.password = passwordTextField.text;
    
//    NSString *aa = @"2018-04-16 20:48:40 -0600";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSDate *bbb;
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
//    bbb = [dateFormatter dateFromString:aa];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm a"];
//    NSString *cc = [dateFormatter stringFromDate:bbb];
//
//    NSLog(@"%@", cc);
    
    Global *globals = [Global sharedInstance];
    
    if(self.username.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingresa tu usuario."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input your username."];
        }
        return;
    }
    if(self.password.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingresa tu contraseña"];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input your password"];
        }
        return;
    }
    if(self.password.length < 6) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"La contraseña debe tener al menos 6 caracteres."];
        } else {
            [self displayAlertView:@"Warning!" :@"Password have to be at least 6 characters"];
        }
        return;
    }

    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];

    NSDictionary *initLogin = @{@"initLogin": @{
                                          @"username": self.username,
                                          @"password": self.password,
                                          @"mac": globals.macAddress
                                          }};
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:initLogin options:0 error:&error];
    NSString *postString = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];

    NSDictionary *parameters = @{
                                 @"method": @"initLogin",
                                 @"param": postString
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
            globals.username = jsonResponse[@"username"];
            globals.idPrivilegio = jsonResponse[@"idPrivilegio"];
            globals.nombreCompleto = jsonResponse[@"nombreCompleto"];
            globals.idUser = jsonResponse[@"idUser"];
            globals.idDispositivo = jsonResponse[@"idDispositivo"];
            globals.login_wsk = jsonResponse[@"WSK"];
            globals.login_uid = jsonResponse[@"UID"];
            globals.nombreComercio = jsonResponse[@"nombreComercio"];
            globals.nombreTerminal = jsonResponse[@"nombreTerminal"];
            globals.emailComercio = jsonResponse[@"emailComercio"];
            globals.numeroRegistro = jsonResponse[@"numeroRegistro"];
            globals.mensajeVoucher = jsonResponse[@"mensajeVoucher"];
            globals.idComercio = jsonResponse[@"idComercio"];
            globals.branchid = jsonResponse[@"branchid"];
            globals.terminalid = jsonResponse[@"terminalid"];
            globals.llaveCifrado = jsonResponse[@"llaveCifrado"];
            globals.cifradoIV = jsonResponse[@"cifradoIV"];
            globals.moneda = jsonResponse[@"moneda"];
            globals.currency = jsonResponse[@"currency"];
            globals.ambiente = jsonResponse[@"ambiente"];

            if([globals.idPrivilegio isEqualToString:@"3"] || [globals.idPrivilegio isEqualToString:@"4"]) {
                [self getShiftCode];
            } else {
                [self performSegueWithIdentifier:@"logintohome_segue" sender:self];
            }

        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"La información de inicio de sesión es incorrecta. Por favor ingrese información válida."];
            } else {
                [self displayAlertView:@"Warning!" :@"Signin information is incorrect. Please input valid information."];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"logintohome_segue"]) {
        SecondViewController *SecondVC;
        SecondVC = [segue destinationViewController];
    }
}

-(void)getShiftCode {
    Global *globals = [Global sharedInstance];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *parameters = @{
                                 @"method": @"getShiftCode",
                                 @"param": globals.idUser
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
            globals.turnoCod = jsonResponse[@"turnoCod"];
            globals.codeShift = jsonResponse[@"codeShift"];
            globals.idTurno = jsonResponse[@"idTurno"];
            
            [self performSegueWithIdentifier:@"logintohome_segue" sender:self];
            
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"No puedes iniciar sesión. El turno del cajero no ha sido asignado."];
            } else {
                [self displayAlertView:@"Warning!" :@"You can't login. The cashier's shift wasn't assigned."];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Error de red."];
        } else {
            [self displayAlertView:@"Warning" :@"Network error."];
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
