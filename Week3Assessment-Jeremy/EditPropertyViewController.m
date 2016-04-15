//
//  EditPropertyViewController.m
//  Week3Assessment-Jeremy
//
//  Created by Jeremy Ong on 15/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "EditPropertyViewController.h"
#import "AppDelegate.h"
#import "PropertiesViewController.h"

@interface EditPropertyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property NSManagedObjectContext *moc;

@end

@implementation EditPropertyViewController

- (void)viewDidLoad {

	AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	self.moc = delegate.managedObjectContext;
	self.nameTextField.text = self.property.name;
	self.priceTextField.text = [self.property.price stringValue];
	self.locationTextField.text = self.property.location;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEditPropertyPressed:(id)sender {
	self.property.name = self.nameTextField.text;
	self.property.price = [NSNumber numberWithInteger:[self.nameTextField.text integerValue]];
	self.property.location = self.locationTextField.text;
	NSError *error;
	[self.moc save:&error];
}

@end
