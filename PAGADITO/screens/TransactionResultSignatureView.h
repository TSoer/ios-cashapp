//
//  TransactionResultSignatureView.h
//  PAGADITO
//
//  Created by Water Flower on 2019/2/8.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransactionResultSignatureView : UIView

@property(nonatomic) UIBezierPath *path;

- (IBAction)clearButtonAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
