//
//  PropertiesViewController.m
//  Week3Assessment-Jeremy
//
//  Created by Jeremy Ong on 15/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "PropertiesViewController.h"
#import "AppDelegate.h"
#import "Properties.h"
#import "AddPropertyViewController.h"
#import "EditPropertyViewController.h"

@interface PropertiesViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *properties;

@end

@implementation PropertiesViewController

- (void)viewDidLoad {
	AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	self.moc = delegate.managedObjectContext;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self loadProperties];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyCell"];
	Properties *property = [self.properties objectAtIndex:indexPath.row];
	cell.textLabel.text = property.name;
	cell.detailTextLabel.text = [[[property.price stringValue] stringByAppendingString:@"  "] stringByAppendingString:property.location];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.properties.count;
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (void)viewDidAppear:(BOOL)animated{
	[self loadProperties];
}

- (void)loadProperties{
	self.properties = [[NSMutableArray alloc] initWithArray:[self.owner.properties allObjects]];
	[self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self performSegueWithIdentifier:@"EditProperty" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([segue.identifier isEqualToString:@"AddProperty"]){
		AddPropertyViewController *destination = segue.destinationViewController;
		destination.owner = self.owner;
	} else if ([segue.identifier isEqualToString:@"EditProperty"]){
		EditPropertyViewController *destination = segue.destinationViewController;
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
		Properties *property = [self.properties objectAtIndex:indexPath.row];
		destination.property = property;
	}
	
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
