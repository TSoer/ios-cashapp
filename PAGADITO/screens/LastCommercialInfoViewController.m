//
//  LastCommercialInfoViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/7.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "LastCommercialInfoViewController.h"
#import "WelcomeViewController.h"
#import "AFNetworking.h"
#import "Global.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface LastCommercialInfoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@property(strong, nonatomic)NSString *macAddress;
@property(strong, nonatomic)NSString *IPAddress;
@property(strong, nonatomic)NSString *osName;
@property(strong, nonatomic)NSString *osVersion;

@property(strong, nonatomic)NSString *commercialName;
@property(strong, nonatomic)NSString *commercialEmail;
@property(strong, nonatomic)NSString *commercialNumber;
@property(strong, nonatomic)NSString *terminalName;
@property(strong, nonatomic)NSString *currencyUnit;

@property(strong, nonatomic)NSMutableArray *currencyNameArray;
@property(strong, nonatomic)NSMutableArray *currencyUnitArray;

@end

@implementation LastCommercialInfoViewController

@synthesize logoImageView, commercialNameTextField, commercialEmailTextField, commercialNumberTextField, terminalNameTextField, currencyTableView, selectCurrencyButton;
@synthesize infoUsuario;
@synthesize titleLabel, commentLabel, imagecommentLabel, continuButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    ///////////   language setting  ////////
    Global *globals = [Global sharedInstance];
    if(globals.selected_language == 0) {
        self.titleLabel.text = @"Información Comercial";
        self.commentLabel.text = @"Personaliza tu Pagadito POS App";
        self.imagecommentLabel.text = @"Logo imagen";
        self.commercialNameTextField.placeholder = @"Nombre Comercial";
        self.terminalNameTextField.placeholder = @"Nombre de Terminal POS";
        [self.selectCurrencyButton setTitle:@"Selecciona una moneda" forState:UIControlStateNormal];
        self.commercialNumberTextField.placeholder = @"Número de Registro (RUC)";
        self.commercialEmailTextField.placeholder = @"Email del Comercio";
        [self.continuButton setTitle:@"Continuar" forState:UIControlStateNormal];
    } else {
        self.titleLabel.text = @"Merchant Information";
        self.commentLabel.text = @"Personalize your Pagadito POS APP";
        self.imagecommentLabel.text = @"Logo image";
        self.commercialNameTextField.placeholder = @"Business Name";
        self.terminalNameTextField.placeholder = @"POS Terminal Name";
        [self.selectCurrencyButton setTitle:@"Select Currency" forState:UIControlStateNormal];
        self.commercialNumberTextField.placeholder = @"Business Registration Number";
        self.commercialEmailTextField.placeholder = @"Business Email";
        [self.continuButton setTitle:@"Continue" forState:UIControlStateNormal];
    }
    /////////////////////////////
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    /////  initialization ////
    self.currencyNameArray = [[NSMutableArray alloc] initWithObjects:@"($) Dólares Americanos", @"(Q) Quetzales", @"(L) Lempiras", @"(C$) Córdobas", @"(₡) Colones Costarricenses", @"(B/.) Balboas", @"(RD$) Pesos Dominicanos", nil];
    self.currencyUnitArray = [[NSMutableArray alloc] initWithObjects:@"USD", @"GTQ", @"HNL", @"NIO", @"CRC", @"PAB", @"DOP", nil];
    
    self.commercialName = @"";
    self.commercialNumber = @"";
    self.commercialEmail = @"";
    self.terminalName = @"";
    self.currencyUnit = @"";
//////////////////////////////////////
    
    [currencyTableView setHidden:YES ];
    
    self.macAddress =globals.macAddress;
    self.IPAddress = globals.IPAddress;
    self.osName = [[UIDevice currentDevice] systemName];
    self.osVersion = [[UIDevice currentDevice] systemVersion];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoImageViewTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [logoImageView setUserInteractionEnabled:YES];
    [logoImageView addGestureRecognizer:singleTap];
    
    
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

- (IBAction)selectCurrencyButtonAction:(id)sender {
    if([currencyTableView isHidden]) {
        [currencyTableView setHidden:NO];
    } else {
        [currencyTableView setHidden:YES];
    }
}

- (IBAction)continueButtonAction:(id)sender {
    Global *globals = [Global sharedInstance];
    self.commercialName = commercialNameTextField.text;
    self.commercialNumber = commercialNumberTextField.text;
    self.commercialEmail = commercialEmailTextField.text;
    self.terminalName = terminalNameTextField.text;
    if((self.commercialName.length == 0) || (self.commercialName.length == 0) || (self.commercialName.length == 0) || (self.commercialName.length == 0) || (self.currencyUnit.length == 0)) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor llene todos los campos." : @"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Please fill all of data." : @"nil"];
        }
        return;
    } else {
        
        [self.activityIndicator startAnimating];
        [self.view addSubview:self.overlayView];
        
        NSDictionary *comercio = @{
                                      @"uid": globals.uid,
                                      @"wsk": globals.wsk,
                                      @"llaveCifrado": globals.private_key,
                                      @"cifradoIV": globals.initialization_vector,
                                      @"nombreComercio": self.commercialName,
                                      @"emailComercio": self.commercialEmail,
                                      @"numeroRegistro": self.commercialNumber
                                      };

        NSDictionary *dispositivo = @{
                                           @"nombreTerminal": self.terminalName,
                                           @"branchid": globals.office_id,
                                           @"terminalid": globals.terminal_id,
                                           @"mac": self.macAddress,
                                           @"moneda": self.currencyUnit,
                                           @"ambiente": @"0",
                                           @"tipoDispositivo": @"Mobile",
                                           @"ipInstalacion": self.IPAddress,
                                           @"sistemaOperativoInstalacion": self.osName,
                                           @"versionSOInstalacion": self.osVersion
                                           };
        
        NSError *error;
        NSData *infoUsuarioData = [NSJSONSerialization dataWithJSONObject:infoUsuario options:0 error:&error];
        NSString *infoUsuarioString = [[NSString alloc]initWithData:infoUsuarioData encoding:NSUTF8StringEncoding];
        NSDictionary *param = @{
                                    @"comercio": comercio,
                                    @"dispositivo": dispositivo,
                                    @"infoUsuario": infoUsuarioString
                                };
        NSData *paramData = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
        NSString *paramString = [[NSString alloc]initWithData:paramData encoding:NSUTF8StringEncoding];
        
        NSDictionary *parameters = @{
                                     @"method": @"insertSetBranchOffice",
                                     @"param": paramString
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
                    [self displayAlertView:@"¡Felicidades!" :@"Instalación realizada exitosamente, Ahora inicia sesión con tu usuario." : @"success"];
                } else {
                    [self displayAlertView:@"Congratulations!" :@"Installation Successful. Now you can login with your username and password." : @"success"];
                }
            } else {
                if(globals.selected_language == 0) {
                    [self displayAlertView:@"¡Advertencia!" :@"INSTALACIÓN FALLIDA. POR FAVOR CONTACTE A SOPORTE!" : @"nil"];
                } else {
                    [self displayAlertView:@"Warning!" :@"FAILED INSTALLATION, PLEASE CONTACT SUPPORT!" : @"nil"];
                }
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.activityIndicator stopAnimating];
            [self.overlayView removeFromSuperview];
            if(globals.selected_language == 0) {
                [self displayAlertView:@"¡Advertencia!" :@"Error de red!" : @"nil"];
            } else {
               [self displayAlertView:@"Warning!" :@"Network error!" : @"nil"];
            }
        }];
        
    }
}

-(void)logoImageViewTapDetected {
    
    UIAlertController *logoImageAlertView = [UIAlertController alertControllerWithTitle:@"Choose Image" message:@"Pick Image from:" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* gallery = [UIAlertAction
                             actionWithTitle:@"Gallery"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                     UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                                     imagePicker.delegate = self;
                                     imagePicker.allowsEditing = YES;
                                     imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                     [self presentViewController:imagePicker animated:YES completion:nil];
                             }];
    
    UIAlertAction* camera = [UIAlertAction
                         actionWithTitle:@"Camera"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                             imagePicker.delegate = self;
                             imagePicker.allowsEditing = YES;
                             imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                             [self presentViewController:imagePicker animated:YES completion:nil];
                         }];
    
    UIAlertAction* cancel = [UIAlertAction
                           actionWithTitle:@"Cancel"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               NSLog(@"Cancel     ");
                           }];
    
    [logoImageAlertView addAction:gallery] ;
    [logoImageAlertView addAction:camera];
    [logoImageAlertView addAction:cancel];
    [self presentViewController:logoImageAlertView animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    Global *globals = [Global sharedInstance];
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.logoImageView.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    

    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"pagadito"];
    // New Folder is your folder name
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *fileName = [stringPath stringByAppendingFormat:@"/pagadito_logo.png"];
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
//    NSLog(@"Image size:: %lu::", (unsigned long)[imageData length]);
    if([imageData length] < 2 * 1024 * 1024) {
        [imageData writeToFile:fileName atomically:YES];
        Global *globals = [Global sharedInstance];
        globals.logo_imagePath = fileName;
    } else {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"La imagen del logo debe ser inferior a 2MB. Por favor seleccione otra imagen." : @"nil"];
        } else {
            [self displayAlertView:@"Warning!" :@"Logo Image have to be less than 2MB. Please select another image." : @"nil"];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currencyNameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.currencyNameArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [selectCurrencyButton setTitle:self.currencyNameArray[indexPath.row] forState:UIControlStateNormal];
    self.currencyUnit = self.currencyUnitArray[indexPath.row];
    [currencyTableView setHidden:YES ];
}

-(void)displayAlertView: (NSString *)header :(NSString *)message : (NSString *)status {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:header message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([status isEqualToString:@"success"]) {
            [self performSegueWithIdentifier:@"lasttowelcome_segue" sender:self];
        }
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"lasttowelcome_segue"]) {
        WelcomeViewController *nextVC = segue.destinationViewController;
//        self.providesPresentationContextTransitionStyle = YES;
//        self.definesPresentationContext = YES;
    }
}



@end
