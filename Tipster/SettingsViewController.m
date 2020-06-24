//
//  SettingsViewController.m
//  Tipster
//
//  Created by Ian Andre Aragon Saenz on 23/06/20.
//  Copyright © 2020 IanAragon. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tipField;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double defaultTip = [defaults doubleForKey:@"default_tip_percentage"];
    
    if(defaultTip == 0.00){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setDouble:0.1 forKey:@"default_tip_percentage"];
        [defaults synchronize];
        defaultTip = .1;
    }
    
    self.tipField.text = [NSString stringWithFormat:@"%d%%", (int)(defaultTip*100.0)];
}
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)tipChange:(id)sender {
    double tip = [self.tipField.text doubleValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble: (tip/100.0) forKey:@"default_tip_percentage"];
    [defaults synchronize];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
