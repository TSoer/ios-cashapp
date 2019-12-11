//
//  VASMerchantConfig
//
//  Created by Alex Wong on 2017-08-18.
//  Copyright 2017 BBPOS LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VASMerchantConfig : NSObject{
    int protocolMode;
    NSString *merchantID;
    NSString *filter;
    NSString *url;
}

@property (nonatomic, assign) int protocolMode;
@property (nonatomic, retain) NSString *merchantID;
@property (nonatomic, retain) NSString *filter;
@property (nonatomic, retain) NSString *url;

@end
