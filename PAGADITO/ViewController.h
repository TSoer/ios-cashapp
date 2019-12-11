//
//  ViewController.h
//  PAGADITO
//
//  Created by Adriana Roldán on 12/7/18.
//  Copyright © 2018 PAGADITO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDeviceController.h"
#import "BBDeviceOTAController.h"

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, BBDeviceControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView_language;
@property (weak, nonatomic) IBOutlet UILabel *pv_txt;

- (IBAction)OKButtonAction:(id)sender;

@end

