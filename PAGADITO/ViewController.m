//
//  ViewController.m
//  PAGADITO
//
//  Created by Adriana Roldán on 12/7/18.
//  Copyright © 2018 PAGADITO. All rights reserved.
//

#import "ViewController.h"
#import "screens/Global.h"
#import "AFNetworking.h"
#import "screens/LoginViewController.h"
#import "screens/WelcomeViewController.h"
#import "BBDeviceController.h"
#import "BBDeviceOTAController.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

#define kTimeout_ScanBT 60

@interface ViewController ()
{
    NSArray *language;
}
@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;
@property(strong, nonatomic)NSString * macAddress;

@end

Global *globals;

@implementation ViewController
@synthesize pickerView_language;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    globals = [Global sharedInstance];
    /////   initalization for global variables
    globals.selected_language = 0;
    globals.uid = @"";
    globals.wsk = @"";
    globals.private_key = @"";
    globals.initialization_vector = @"";
    globals.office_id = @"";
    globals.terminal_id = @"";
    globals.logo_image = nil;
    globals.logo_imagePath = @"";
    
    globals.signatureStatus = false;
    
    language = @[@"Español",@"English"];
    self.pickerView_language.dataSource = self;
    self.pickerView_language.delegate = self;
    
    /////  get IP address  //////
    [self getIPAddress];
    
    ///////  language picker setting
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    if([[[userdefault dictionaryRepresentation] allKeys] containsObject:@"selected_language"]) {
            globals.selected_language = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected_language"];
        }
    [self.pickerView_language selectRow:globals.selected_language inComponent:0 animated:YES];
    
    ///////////// logo image load   ///////////
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", @"pagadito/pagadito_logo"]];
    BOOL fileExists=[[NSFileManager defaultManager] fileExistsAtPath:imagePath];
    
    if(fileExists) {
        globals.logo_imagePath = imagePath;
    }else {
        globals.logo_imagePath = @"";
    }
    
    //////////////////////////////////////////
    self.macAddress = [self getMacAddress];
    globals.macAddress = self.macAddress;
    NSLog(@"%@", globals.macAddress);
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];

    NSDictionary *parameters = @{
                                 @"method": @"initSystem",
                                 @"param": self.macAddress
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

        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];

        NSString *statusValue = jsonResponse[@"status"];
        NSInteger statusInt = [statusValue integerValue];
        if(statusInt == 1) {
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            if([[[userdefault dictionaryRepresentation] allKeys] containsObject:@"selected_language"]) {
                globals.selected_language = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected_language"];
            }
            [self performSegueWithIdentifier:@"firsttowelcome_segue" sender:self];
        } else if(statusInt == 2){

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        if(globals.selected_language == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"¡Advertencia!" message:@"Error de red." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK action");
            }];
            [alert addAction:actionOK];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Networking error." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"OK action");
            }];
            [alert addAction:actionOK];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
}

- (IBAction)OKButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"firsttologin_segue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"firsttologin_segue"]) {
        LoginViewController *LoginVC;
        LoginVC = [segue destinationViewController];
    } else if([segue.identifier isEqualToString:@"firsttowelcome_segue"]) {
        WelcomeViewController *WelcomeVC;
        WelcomeVC = [segue destinationViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return language.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return language[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    self.pv_txt.text = language[row];
    
    globals.selected_language = row;
    [[NSUserDefaults standardUserDefaults] setInteger:row forKey:@"selected_language"];
    
}


// get the mac address of current-device
-(NSString *)getMacAddress
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"";
}

// get the IP address of current-device
- (void)getIPAddress {
    globals = [Global sharedInstance];
    NSURL *url = [NSURL URLWithString:@"https://api.ipify.org/"];
    NSString *ipAddress = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"My public IP address is: %@", ipAddress);
    globals.IPAddress = ipAddress;
}

@end
