//
//  ResetPasswordConfirmViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/21.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "ResetPasswordConfirmViewController.h"
#import "AFNetworking.h"
#import "WelcomeViewController.h"
#import "Global.h"

@interface ResetPasswordConfirmViewController ()
@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@property(strong, nonatomic)NSString *passwordText;
@property(strong, nonatomic)NSString *confirmText;

@end

@implementation ResetPasswordConfirmViewController
@synthesize idUser;
@synthesize passwordTextField, confirmTextField, TransV, successAlertView;
@synthesize titleLabel, commentLabel, successcommentLabel, saveButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passwordTextField.layer.borderColor = [[UIColor colorWithRed:35.0f/255.0f green:135.0f/255.0f blue:215.0f/255.0f alpha:1.0] CGColor];
    self.passwordTextField.layer.borderWidth = 1.0;
    UIView *paddingPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)];
    self.passwordTextField.leftView = paddingPasswordView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.confirmTextField.layer.borderColor = [[UIColor colorWithRed:35.0f/255.0f green:135.0f/255.0f blue:215.0f/255.0f alpha:1.0] CGColor];
    self.confirmTextField.layer.borderWidth = 1.0;
    UIView *paddingConfirmView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)];
    self.confirmTextField.leftView = paddingConfirmView;
    self.confirmTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    
    //// dismiss keyboard  //////////
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    Global *globals = [Global sharedInstance];
    if(globals.selected_language == 0) {
        self.titleLabel.text = @"Reestablecer Contraseña";
        self.commentLabel.text = @"Ingresa tu nueva contraseña";
        self.passwordTextField.placeholder = @"Nueva contraseña";
        self.confirmTextField.placeholder = @"Confirmar contraseña";
        [self.saveButton setTitle:@"Guardar" forState:UIControlStateNormal];
        self.successcommentLabel.text = @"Tu contraseña ha sido reestablecida con éxito";
    } else {
        self.titleLabel.text = @"Reset Password";
        self.commentLabel.text = @"Enter your new password";
        self.passwordTextField.placeholder = @"New Password";
        self.confirmTextField.placeholder = @"Confirm Password";
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        self.successcommentLabel.text = @"Your password has been reset successfuly";
    }
    
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)saveButtonAction:(id)sender {
    self.passwordText = self.passwordTextField.text;
    self.confirmText = self.confirmTextField.text;
    
    Global *globals = [Global sharedInstance];
    
    if(self.passwordText.length == 0) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor ingrese una nueva contraseña."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please input new password."];
        }
        return;
    }
    if(self.passwordText.length < 6) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"La contraseña debe tener al menos 6 caracteres."];
        } else {
            [self displayAlertView:@"Warning!" :@"Password have to be at least 6 characters"];
        }
        return;
    }
    if(![self.passwordText isEqualToString:self.confirmText]) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Las contraseñas no coinciden."];
        } else {
            [self displayAlertView:@"Warning!" :@"Password does not match."];
        }
        return;
    }
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    NSDictionary *restorePswd = @{@"restorePswd": @{
                                       @"newpassword": self.passwordText,
                                       @"idUser": self.idUser
                                       }};
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:restorePswd options:0 error:&error];
    NSString *string = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{
                                 @"method": @"restoreAdminPwd",
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
            [self.TransV setHidden:NO];
            [self.successAlertView setHidden:NO];
        } else {
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"No puede utilizar la contraseña actual, ingrese una nueva contraseña."];
            } else {
                [self displayAlertView:@"Warning!" :@"You can't use your current password. Please use a new one."];
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

- (IBAction)successAlertViewOKButtonAction:(id)sender {
    [self.TransV setHidden:YES];
    [self.successAlertView setHidden:YES];
    [self performSegueWithIdentifier:@"confirmpasswordtowelcome_segue" sender:self];
}

- (IBAction)backButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"confirmpasswordtowelcome_segue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"confirmpasswordtowelcome_segue"]) {
        WelcomeViewController *WelcomeVC;
        WelcomeVC = segue.destinationViewController;
    }
}

-(void)displayAlertView: (NSString *)header :(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
