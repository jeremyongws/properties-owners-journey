//
//  AddPropertyViewController.m
//  Week3Assessment-Jeremy
//
//  Created by Jeremy Ong on 15/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "AppDelegate.h"
#import "Properties.h"
#import "PropertiesViewController.h"

@interface AddPropertyViewController ()

@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@end

@implementation AddPropertyViewController

- (void)viewDidLoad {
	AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	self.moc = delegate.managedObjectContext;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onAddPropertyButtonPressed:(id)sender {
	Properties *property = [NSEntityDescription insertNewObjectForEntityForName:@"Properties" inManagedObjectContext:self.moc];
	property.name = self.nameTextField.text;
	property.price = [[NSNumber alloc] initWithInteger:[self.priceTextField.text integerValue]];
	property.location = self.locationTextField.text;
	[self.owner addPropertiesObject:property];
	NSError *error;
	[self.moc save:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
