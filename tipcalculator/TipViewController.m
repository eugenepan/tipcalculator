//
//  TipViewController.m
//  tipcalculator
//
//  Created by Eugene Pan on 10/6/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *numGuestsTextField;
@property (weak, nonatomic) IBOutlet UILabel *splitTextField;

- (IBAction)onTap:(id)sender;
- (void)updateValue;
- (void)saveBill;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.billTextField.text = [defaults objectForKey:@"billValue"];
    [self updateValue];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self saveBill];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:(YES)];
    [self updateValue];
    [self saveBill];
}

- (void)updateValue {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.
                                              selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float guestNum = [[defaults objectForKey:@"defaultGuestNum"] floatValue];
    self.numGuestsTextField.text = [defaults objectForKey:@"defaultGuestNum"];
    self.splitTextField.text = [NSString stringWithFormat:@"$%0.2f / Guest", totalAmount/guestNum];
}

-(void)saveBill {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.billTextField.text forKey:@"billValue"];
    [defaults synchronize];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
