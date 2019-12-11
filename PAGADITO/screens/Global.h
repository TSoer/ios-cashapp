//
//  Global.h
//  PAGADITO
//
//  Created by Water Flower on 2019/1/6.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Global : NSObject
{
    NSString *server_url;

    NSInteger selected_language;
    NSString *macAddress;
    NSString *IPAddress;
    NSString *uid;
    NSString *wsk;
    NSString *private_key;
    NSString *initialization_vector;
    NSString *office_id;
    NSString *terminal_id;
    
    NSString *logo_imagePath;
    UIImage *logo_image;
    
//    signin information
    NSString *username;
    NSString *idPrivilegio;
    NSString *nombreCompleto;
    NSString *idUser;
    NSString *idDispositivo;
    NSString *login_wsk;
    NSString *login_uid;;
    NSString *llaveCifrado;
    NSString *cifradoIV;
    NSString *moneda;
    NSString *nombreComercio;
    NSString *nombreTerminal;
    NSString *numeroRegistro;
    NSString *mensajeVoucher;
    NSString *emailComercio;
    NSString *currency;
    NSString *idComercio;
    NSString *branchid;
    NSString *terminalid;
    NSString *ambiente;
    
    
    //getshiftCode information
    NSString *turnoCod;
    NSString *codeShift;
    NSString *idTurno;
    
    BOOL signatureStatus;
    
    
}

+ (Global *)sharedInstance;

@property(strong, nonatomic, readwrite) NSString *server_url;

@property(nonatomic, readwrite) NSInteger selected_language;
@property(strong, nonatomic, readwrite) NSString *macAddress;
@property(strong, nonatomic, readwrite) NSString *IPAddress;
@property(strong, nonatomic, readwrite) NSString *uid;
@property(strong, nonatomic, readwrite) NSString *wsk;
@property(strong, nonatomic, readwrite) NSString *private_key;
@property(strong, nonatomic, readwrite) NSString *initialization_vector;
@property(strong, nonatomic, readwrite) NSString *office_id;
@property(strong, nonatomic, readwrite) NSString *terminal_id;
@property(strong, nonatomic, readwrite) NSString *logo_imagePath;
@property(strong, nonatomic, readwrite) UIImage *logo_image;

@property(strong, nonatomic, readwrite) NSString *username;
@property(strong, nonatomic, readwrite) NSString *idPrivilegio;
@property(strong, nonatomic, readwrite) NSString *nombreCompleto;
@property(strong, nonatomic, readwrite) NSString *idUser;
@property(strong, nonatomic, readwrite) NSString *idDispositivo;
@property(strong, nonatomic, readwrite) NSString *login_wsk;
@property(strong, nonatomic, readwrite) NSString *login_uid;
@property(strong, nonatomic, readwrite) NSString *llaveCifrado;
@property(strong, nonatomic, readwrite) NSString *cifradoIV;
@property(strong, nonatomic, readwrite) NSString *moneda;
@property(strong, nonatomic, readwrite) NSString *nombreComercio;
@property(strong, nonatomic, readwrite) NSString *nombreTerminal;
@property(strong, nonatomic, readwrite) NSString *numeroRegistro;
@property(strong, nonatomic, readwrite) NSString *mensajeVoucher;
@property(strong, nonatomic, readwrite) NSString *emailComercio;
@property(strong, nonatomic, readwrite) NSString *currency;
@property(strong, nonatomic, readwrite) NSString *idComercio;
@property(strong, nonatomic, readwrite) NSString *branchid;
@property(strong, nonatomic, readwrite) NSString *terminalid;
@property(strong, nonatomic, readwrite) NSString *ambiente;

@property(strong, nonatomic, readwrite) NSString *turnoCod;
@property(strong, nonatomic, readwrite) NSString *codeShift;
@property(strong, nonatomic, readwrite) NSString *idTurno;

@property(nonatomic) BOOL signatureStatus;

@end
