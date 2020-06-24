//
//  ViewController.m
//  Tipster
//
//  Created by Ian Andre Aragon Saenz on 23/06/20.
//  Copyright © 2020 IanAragon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double defaultTip = [defaults doubleForKey:@"default_tip_percentage"];
    
    if(defaultTip == 0.00){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setDouble:0.1 forKey:@"default_tip_percentage"];
        [defaults synchronize];
        defaultTip = .1;
    }
    
    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%", (int)(defaultTip*100.0) ]  forSegmentAtIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Tipster Calculator";
}

- (IBAction)onEdit:(id)sender {
    double bill = [self.billField.text doubleValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double defaultTip = [defaults doubleForKey:@"default_tip_percentage"];

    if(defaultTip == 0.00) defaultTip = .1;
    NSArray *percentages = @[@(defaultTip), @(.15), @(.2)];
    double percentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = bill * percentage;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%f", total];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)onEditingBegin:(id)sender {
    
    [UIView animateWithDuration:.2 animations:^{
        self.billField.frame = CGRectMake(self.billField.frame.origin.x ,self.billField.frame.origin.y, self.billField.frame.size.width,  self.billField.frame.size.height);
        
    }];
    
}
- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.billField.frame;
    
    newFrame.origin.y -= 30;
    [UIView animateWithDuration:.2 animations:^{
        self.billField.frame = newFrame;
    }];
    
}

@end
