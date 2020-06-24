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
    //loading of values
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
    
    //loading the saved bill if any
    double bill = [defaults doubleForKey:@"bill"];
    
    if(bill != 0.0){
        self.billField.text = [NSString stringWithFormat:@"$%f", bill];
    }
    
    NSArray *percentages = @[@(defaultTip), @(.15), @(.2)];
    double percentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = bill * percentage;
    double total = bill + tip;
        
    self.tipLabel.text = [NSString stringWithFormat:@"$%f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%f", total];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Tipster Calculator";
}

- (IBAction)onEdit:(id)sender {
    double bill = [self.billField.text doubleValue];
        
    //loading default tip
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double defaultTip = [defaults doubleForKey:@"default_tip_percentage"];
    
    //calculation of tips and showing outcomes in view
    if(defaultTip == 0.00) defaultTip = .1;
    
    NSArray *percentages = @[@(defaultTip), @(.15), @(.2)];
    double percentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = bill * percentage;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%f", total];
    
    //saving the bill
    [defaults setDouble:bill forKey:@"bill"];
    [defaults synchronize];
}

- (IBAction)onTap:(id)sender {
    //disables keyboard
    [self.view endEditing:YES];
}
                           
- (IBAction)onEditingBegin:(id)sender {
    //animation when selecting billField
    [UIView animateWithDuration:.3 animations:^{
        self.billField.frame = CGRectMake(self.billField.frame.origin.x -70 ,self.billField.frame.origin.y, self.billField.frame.size.width+20,  self.billField.frame.size.height+10);
        
        self.billField.backgroundColor = [UIColor colorWithRed:149.0f green:2.0f blue:239.0f alpha:.50001f];
        
    }];
    
}
                           
- (IBAction)onEditingEnd:(id)sender {
    //animation when deselecting billField
    CGRect newFrame = self.billField.frame;
    
    newFrame.origin.x += 70;
    newFrame.size.height -= 10;
    newFrame.size.width -= 20;
    
    [UIView animateWithDuration:.3 animations:^{
        self.billField.frame = newFrame;
        self.billField.backgroundColor = [UIColor colorWithRed:195.0f green:247.0f blue:225.0f alpha:0.0f];
    }];
    
}

@end
