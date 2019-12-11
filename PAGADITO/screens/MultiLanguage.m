//
//  MultiLanguage.m
//  PAGADITO
//
//  Created by Water Flower on 2019/1/31.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiLanguage.h"

@implementation MultiLanguage

@synthesize signinVC_comment1LabelText, signinVC_comment2LabelText, signinVC_username, signinVC_password, signinVC_explain, signinVC_signinButtonText, signinVC_forgotpasswordText;
@synthesize selectstoreVC_titleText, selectstoreVC_CommentText, selectstoreVC_continueButtonText, selectstoreVC_selectStoreButtonText, selectstoreVC_selectStoreCommentText, selectstoreVC_selectTerminalButtonText, selectstoreVC_selectTerminalCommentText;
@synthesize usercreationVC_titleText, usercreationVC_selectRoleButtonText, usercreationVC_checkboxcommentLabelText, usercreationVC_pincodecommentLabelText, usercreationVC_firstnameTextFieldPlaceholder, usercreationVC_lastTextFieldPlaceholder, usercreationVC_usernameTextFieldPlaceholder, usercreationVC_passwordTextFieldPlaceholder, usercreationVC_confirmTextFieldPlaceholder, usercreationVC_continueButtonText, usercreationVC_admincontinueButtonText, usercreationVC_unicocontinueButtonText, usercreationVC_role_list;


+ (MultiLanguage *)sharedInstance {
    static dispatch_once_t onceToken;
    static MultiLanguage *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[MultiLanguage alloc] init];
    });
    return instance;
}

-(id)init {
    self = [super init];
    if(self) {
        //        uid = nil;
        //// sign in VC
        self.signinVC_comment1LabelText = [[NSMutableArray alloc] initWithObjects:@"Configuración Inicial", @"Pagadito POS", nil];
        self.signinVC_comment2LabelText = [[NSMutableArray alloc] initWithObjects:@"Pagadito POS", @"Initial Setup", nil];
        self.signinVC_username = [[NSMutableArray alloc] initWithObjects:@"Correo Electrónico", @"Email", nil];
        self.signinVC_password = [[NSMutableArray alloc] initWithObjects:@"Contraseña", @"Password", nil];
        self.signinVC_explain = [[NSMutableArray alloc] initWithObjects:@"Inicia sesión con tu cuenta Pagadito", @"Sign in with your Pagadito account information", nil];
        self.signinVC_signinButtonText = [[NSMutableArray alloc] initWithObjects:@"Inicia sesión", @"Sign In", nil];
        self.signinVC_forgotpasswordText = [[NSMutableArray alloc] initWithObjects:@"Olvidé mi contraseña", @"Forgot Password", nil];
        
        ////  selectstore  VC
        self.selectstoreVC_titleText = [[NSMutableArray alloc] initWithObjects:@"Configuración Inicial", @"Initial Setup", nil];
        self.selectstoreVC_selectStoreCommentText = [[NSMutableArray alloc] initWithObjects:@"Elige la sucursal donde utilizarás tu POS App:", @"Choose the branch where you will use your POS App:", nil];
        self.selectstoreVC_selectStoreButtonText = [[NSMutableArray alloc] initWithObjects:@"Selecciona una sucursal", @"Select a Store Location", nil];
        self.selectstoreVC_selectTerminalCommentText = [[NSMutableArray alloc] initWithObjects:@"Asigna una terminal para realizar tus transacciones:", @"Assign a terminal to perform your transactions:", nil];
        self.selectstoreVC_selectTerminalButtonText = [[NSMutableArray alloc] initWithObjects:@"Selecciona una terminal", @"Select a POS Terminal", nil];
        self.selectstoreVC_CommentText = [[NSMutableArray alloc] initWithObjects:@"Si no ves una sucursal o terminal disponible, debes configurarla aquí.", @"If you do not see a branch or terminal available, you must configure it here.", nil];
        self.selectstoreVC_continueButtonText = [[NSMutableArray alloc] initWithObjects:@"Continuar", @"Continue", nil];
        
        ////  user creation VC
        self.usercreationVC_titleText = [[NSMutableArray alloc] initWithObjects:@"Nuevo Usuario", @"New User Information", nil];
        self.usercreationVC_selectRoleButtonText = [[NSMutableArray alloc] initWithObjects:@"Selecciona un rol de usuario", @"Select User Priviledges", nil];
        self.usercreationVC_checkboxcommentLabelText = [[NSMutableArray alloc] initWithObjects:@"Asignar nuevo turno automaticamente todos los días.", @"Automatically assign shift every day", nil];
        self.usercreationVC_pincodecommentLabelText = [[NSMutableArray alloc] initWithObjects:@"PIN de autorización:", @"Authorization PIN:", nil];
        self.usercreationVC_firstnameTextFieldPlaceholder = [[NSMutableArray alloc] initWithObjects:@"Nombres", @"First Name", nil];
        self.usercreationVC_lastTextFieldPlaceholder = [[NSMutableArray alloc] initWithObjects:@"Apellidos", @"Last Name", nil];
        self.usercreationVC_usernameTextFieldPlaceholder = [[NSMutableArray alloc] initWithObjects:@"Usuario", @"Username", nil];
        self.usercreationVC_passwordTextFieldPlaceholder = [[NSMutableArray alloc] initWithObjects:@"Contraseña", @"Password", nil];
        self.usercreationVC_confirmTextFieldPlaceholder = [[NSMutableArray alloc] initWithObjects:@"Confirmar Contraseña", @"Confirm Password", nil];
        self.usercreationVC_continueButtonText = [[NSMutableArray alloc] initWithObjects:@"Continuar", @"Continue", nil];
        self.usercreationVC_admincontinueButtonText = [[NSMutableArray alloc] initWithObjects:@"Guardar y crear otro usuario", @"Save and create another user", nil];
        self.usercreationVC_unicocontinueButtonText = [[NSMutableArray alloc] initWithObjects:@"Guardar y continuar", @"Save and continue", nil];
         self.usercreationVC_role_list = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"Administrador", @"Administrador Único", nil], [[NSMutableArray alloc] initWithObjects:@"Administrator", @"Administrator Single", nil], nil];
        
    }
    return self;
}

@end
