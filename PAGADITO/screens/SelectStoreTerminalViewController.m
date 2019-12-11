//
//  SelectStoreTerminalViewController.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/5.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "SelectStoreTerminalViewController.h"
#import "AFNetworking.h"
#import "Global.h"
#import "UserCreationViewController.h"
#import "MultiLanguage.h"

@interface SelectStoreTerminalViewController () <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property(strong, nonatomic)UIView *overlayView;
@property(strong, nonatomic)UIActivityIndicatorView * activityIndicator;

@property (nonatomic, strong)NSMutableArray *store_list;
@property (nonatomic, strong)NSMutableArray *storeID_list;
@property (nonatomic, strong)NSMutableArray *terminal_list;
@property (nonatomic, strong)NSMutableArray *terminalID_list;

@end

@implementation SelectStoreTerminalViewController
@synthesize storeTableView, selectStoreButton, terminalTableView, selectTerminalButton;
@synthesize xmlStoreParser, xmlTerminalParser;
@synthesize storeTableViewHeightConstraint, terminalTableViewHeightConstraint;
@synthesize titleLabel, selectStoreCommentLabel, selectTerminalCommentLabel, commentLabel, continueButton;

bool isBranchOffices = false;
bool isOffice = false;
bool isOffice_id = false;
bool isOffice_name = false;

bool isTerminals = false;
bool isTerminal = false;
bool isTerminal_id = false;
bool isTerminal_name = false;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.store_list = [[NSMutableArray alloc] initWithObjects: @"store1", @"store2", @"store3", @"store4", @"store5", @"store6", @"store7", @"store8", nil];
//    self.terminal_list = [[NSMutableArray alloc] initWithObjects: @"terminal1", @"terminal2", @"terminal3", @"terminal4", @"terminal5", @"terminal6", @"terminal7", nil];
    
    Global *globals = [Global sharedInstance];
    ///////   multilanuage setting   ////////
    MultiLanguage *multiLanguage = [MultiLanguage sharedInstance];
    self.titleLabel.text = multiLanguage.selectstoreVC_titleText[globals.selected_language];
    self.selectStoreCommentLabel.text = multiLanguage.selectstoreVC_selectStoreCommentText[globals.selected_language];
    [self.selectStoreButton setTitle:multiLanguage.selectstoreVC_selectStoreButtonText[globals.selected_language] forState:UIControlStateNormal];
    self.selectTerminalCommentLabel.text = multiLanguage.selectstoreVC_selectTerminalCommentText[globals.selected_language];
    [self.selectTerminalButton setTitle:multiLanguage.selectstoreVC_selectTerminalButtonText[globals.selected_language] forState:UIControlStateNormal];
    self.commentLabel.text = multiLanguage.selectstoreVC_CommentText[globals.selected_language];
    [self.continueButton setTitle:multiLanguage.selectstoreVC_continueButtonText[globals.selected_language] forState:UIControlStateNormal];
    //////////////////////////////////////////
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.overlayView];
    
    self.store_list = [[NSMutableArray alloc] init];
    self.storeID_list = [[NSMutableArray alloc] init];
    self.terminal_list = [[NSMutableArray alloc] init];
    self.terminalID_list = [[NSMutableArray alloc] init];
    
    
    globals.office_id = @"";
    
    [terminalTableView setHidden:YES ];
    [storeTableView setHidden:YES ];
    
    
    NSDictionary *credentials = @{@"credentials": @{
                                          @"uid": globals.uid,
                                          @"wsk": globals.wsk,
                                          @"ambiente": @"0"
                                          }};

    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:credentials options:0 error:&error];
    NSString *string = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameters = @{
                                 @"method": @"getBranchOffices",
                                 @"credentials": string
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
        if([jsonResponse[@"code"] isEqualToString: @"PG1024"]) {
            
            
            NSString *num_branch_offices = jsonResponse[@"value"][@"num_branch_offices"];
            NSString *xml_branch_offices = jsonResponse[@"value"][@"xml_branch_offices"];
            
            if([num_branch_offices intValue] > 0) {
                NSData *xmlData = [xml_branch_offices dataUsingEncoding:NSUTF8StringEncoding];
                self.xmlStoreParser = [[NSXMLParser alloc] initWithData:xmlData];
                self.xmlStoreParser.delegate = self;
                
                [self.xmlStoreParser parse];
                
            }
            
            
            
        } else {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Incorrect email or password" preferredStyle:UIAlertControllerStyleAlert];
//            UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSLog(@"OK action");
//            }];
//            [alert addAction:actionOK];
//            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicator stopAnimating];
        [self.overlayView removeFromSuperview];
        NSLog(@"bbbb %@", error);
    }];
    
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    //////   this part is for getting office data
    if([elementName isEqualToString:@"branch_offices"]) {
        isBranchOffices = true;
    }
    if([elementName isEqualToString:@"office"]) {
        isOffice = true;
    }
    if(isOffice && [elementName isEqualToString:@"office_id"]) {
        isOffice_id = true;
    }
    if(isOffice && [elementName isEqualToString:@"office_name"]) {
        isOffice_name = true;
    }
    
    
    //////   this part is for getting terminal data
    if([elementName isEqualToString:@"terminals"]) {
        isTerminals = true;
    }
    if([elementName isEqualToString:@"terminal"]) {
        isTerminal = true;
    }
    if(isTerminal && [elementName isEqualToString:@"terminal_id"]) {
        isTerminal_id = true;
    }
    if(isTerminal && [elementName isEqualToString:@"terminal_name"]) {
        isTerminal_name = true;
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //////   this part is for getting office data
    if([elementName isEqualToString:@"branch_offices"]) {
        if(isBranchOffices) {
            [self.storeTableView reloadData];
            int storeTableViewHeight = 40 * self.store_list.count;
            if(storeTableViewHeight > 150) {
                storeTableViewHeight = 150;
            }
            storeTableViewHeightConstraint.constant = 40 * self.store_list.count;
        }
    }
    if([elementName isEqualToString:@"office_id"]) {
        isOffice_id = false;
    }
    if([elementName isEqualToString:@"office_name"]) {
        isOffice_name = false;
    }
    
    //////   this part is for getting terminal data
    if([elementName isEqualToString:@"terminals"]) {
        if(isTerminals) {
            [self.terminalTableView reloadData];
            [selectTerminalButton setTitle:self.terminal_list[0] forState:UIControlStateNormal];
            int terminalTableViewHeight = 40 * self.terminal_list.count;
            if(terminalTableViewHeight > 150) {
                terminalTableViewHeight = 150;
            }
            terminalTableViewHeightConstraint.constant = 40 * self.terminal_list.count;
        }
    }
    if([elementName isEqualToString:@"terminal_id"]) {
        isTerminal_id = false;
    }
    if([elementName isEqualToString:@"terminal_name"]) {
        isTerminal_name= false;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //////   this part is for getting office data
    if(isOffice_id) {
        [self.storeID_list addObject:string];
    }
    if(isOffice_name) {
        [self.store_list addObject:string];
//        [self.storeTableView reloadData];
    }
    
    //////   this part is for getting terminal data
    if(isTerminal_id) {
        [self.terminalID_list addObject:string];
        Global *globals = [Global sharedInstance];
        globals.terminal_id = self.terminalID_list[0];
    }
    if(isTerminal_name) {
        [self.terminal_list addObject:string];
//        [self.terminalTableView reloadData];
//        [selectTerminalButton setTitle:self.terminal_list[0] forState:UIControlStateNormal];
    }
}


- (IBAction)selectStoreButtonAction:(id)sender {
    if([storeTableView isHidden]) {
        [storeTableView setHidden:NO ];
    } else {
      [storeTableView setHidden:YES ];
    }
}

- (IBAction)selectTerminalButtonAction:(id)sender {
    if ([terminalTableView isHidden])
        [terminalTableView setHidden:NO ];
    else
        [terminalTableView setHidden:YES ];
}

- (IBAction)continueButtonAction:(id)sender {
    Global *globals = [Global sharedInstance];
    if(!globals.office_id.length) {
        if(globals.selected_language == 0) {
            [self displayAlertView:@"¡Advertencia!" :@"Por favor seleccione una sucursal."];
        } else {
            [self displayAlertView:@"Warning!" :@"Please select a store."];
        }
    } else {
        [self performSegueWithIdentifier:@"logintoselect_segue" sender:nil];
        NSLog(@"ggggggg:%@", self.store_list);
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserCreationViewController *nextVC = segue.destinationViewController;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    if(tableView == terminalTableView) {
        count = self.terminal_list.count;
        
        return count;
    } else if(tableView == storeTableView) {
        count = self.store_list.count;
        return count;
    } else {
        NSLog(@"sss: %lu", (unsigned long)self.terminal_list.count);
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == terminalTableView) {
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = self.terminal_list[indexPath.row];
        return cell;
    } else if(tableView == storeTableView) {
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [self.store_list objectAtIndex:indexPath.row];
        return cell;
    } else {
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == terminalTableView) {
        [selectTerminalButton setTitle:_terminal_list[indexPath.row] forState:UIControlStateNormal];
        [terminalTableView setHidden:YES ];
        
        Global *globals = [Global sharedInstance];
        globals.terminal_id = self.terminalID_list[indexPath.row];
        
    } else if(tableView == storeTableView) {
        [selectStoreButton setTitle:_store_list[indexPath.row] forState:UIControlStateNormal];
        [storeTableView setHidden:YES ];
        
        [self.activityIndicator startAnimating];
        [self.view addSubview:self.overlayView];
        
        Global *globals = [Global sharedInstance];
        NSDictionary *credentials = @{
                                      @"uid": globals.uid,
                                      @"wsk": globals.wsk,
                                      @"ambiente": @"0"
                                     };
        
        NSError *error;
        NSData *credentialsData = [NSJSONSerialization dataWithJSONObject:credentials options:0 error:&error];
        NSString *credentialsString = [[NSString alloc]initWithData:credentialsData encoding:NSUTF8StringEncoding];
        
        NSDictionary *terminal = @{
                                   @"branch_office_id": self.storeID_list[indexPath.row],
                                   @"terminals_type_id": @"20",
                                   };
        
        NSData *terminalData = [NSJSONSerialization dataWithJSONObject:terminal options:0 error:&error];
        NSString *terminalString = [[NSString alloc]initWithData:terminalData encoding:NSUTF8StringEncoding];
        
        NSDictionary *parameters = @{
                                         @"method": @"getTerminals",
                                         @"credentials": credentialsString,
                                         @"terminal": terminalString
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
            
//            NSLog(@"zzzzz: %ld :::  %@", (long)indexPath.row, jsonResponse);
            if([jsonResponse[@"code"] isEqualToString: @"PG1025"]) {
                
                globals.office_id = self.storeID_list[indexPath.row];
                
                NSString *num_terminals = jsonResponse[@"value"][@"num_terminals"];
                NSString *xml_terminals = jsonResponse[@"value"][@"xml_terminals"];
                
                if([num_terminals intValue] > 0) {
                    NSData *xmlData = [xml_terminals dataUsingEncoding:NSUTF8StringEncoding];
                    self.xmlTerminalParser = [[NSXMLParser alloc] initWithData:xmlData];
                    self.xmlTerminalParser.delegate = self;
                    
                    [self.xmlTerminalParser parse];
                }
                
                
            } else {
                //            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Incorrect email or password" preferredStyle:UIAlertControllerStyleAlert];
                //            UIApplication *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                NSLog(@"OK action");
                //            }];
                //            [alert addAction:actionOK];
                //            [self presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.activityIndicator stopAnimating];
            [self.overlayView removeFromSuperview];
            NSLog(@"bbbb %@", error);
        }];
    }
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
