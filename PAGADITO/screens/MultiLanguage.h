//
//  MultiLanguage.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/31.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MultiLanguage : NSObject
{
    ///   sign in View Controller
    NSMutableArray *signinVC_comment1LabelText;
    NSMutableArray *signinVC_comment2LabelText;
    NSMutableArray *signinVC_username;
    NSMutableArray *signinVC_password;
    NSMutableArray *signinVC_explain;
    NSMutableArray *signinVC_signinButtonText;
    NSMutableArray *signinVC_forgotpasswordTExt;
    
    ///  select store View Controller
    NSMutableArray *selectstoreVC_titleText;
    NSMutableArray *selectstoreVC_selectStoreCommentText;
    NSMutableArray *selectstoreVC_selectStoreButtonText;
    NSMutableArray *selectstoreVC_selectTerminalCommentText;
    NSMutableArray *selectstoreVC_selectTerminalButtonText;
    NSMutableArray *selectstoreVC_CommentText;
    NSMutableArray *selectstoreVC_continueButtonText;
    
    /////  user creation View Controller
    NSMutableArray *usercreationVC_titleText;
    NSMutableArray *usercreationVC_selectRoleButtonText;
    NSMutableArray *usercreationVC_checkboxcommentLabelText;
    NSMutableArray *usercreationVC_pincodecommentLabelText;
    NSMutableArray *usercreationVC_firstnameTextFieldPlaceholder;
    NSMutableArray *usercreationVC_lastTextFieldPlaceholder;
    NSMutableArray *usercreationVC_usernameTextFieldPlaceholder;
    NSMutableArray *usercreationVC_passwordTextFieldPlaceholder;
    NSMutableArray *usercreationVC_confirmTextFieldPlaceholder;
    NSMutableArray *usercreationVC_continueButtonText;
    NSMutableArray *usercreationVC_admincontinueButtonText;
    NSMutableArray *usercreationVC_unicocontinueButtonText;
    NSMutableArray *usercreationVC_role_list;
    
}

+ (MultiLanguage *)sharedInstance;

///   sign in View Controller
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_comment1LabelText;
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_comment2LabelText;
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_username;
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_password;
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_explain;
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_signinButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *signinVC_forgotpasswordText;

///  select store View Controller
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_titleText;
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_selectStoreCommentText;
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_selectStoreButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_selectTerminalCommentText;
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_selectTerminalButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_CommentText;
@property(strong, nonatomic, readwrite)NSMutableArray *selectstoreVC_continueButtonText;

/////  user creation View Controller
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_titleText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_selectRoleButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_checkboxcommentLabelText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_pincodecommentLabelText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_firstnameTextFieldPlaceholder;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_lastTextFieldPlaceholder;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_usernameTextFieldPlaceholder;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_passwordTextFieldPlaceholder;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_confirmTextFieldPlaceholder;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_continueButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_admincontinueButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_unicocontinueButtonText;
@property(strong, nonatomic, readwrite)NSMutableArray *usercreationVC_role_list;

@end

