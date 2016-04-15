//
//  ViewController.m
//  Week3Assessment-Jeremy
//
//  Created by Jeremy Ong on 15/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "OwnerViewController.h"
#import "PropertiesViewController.h"
#import "AppDelegate.h"
#import "Owner.h"

@interface OwnerViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSManagedObjectContext *moc;
@property NSMutableArray *owners;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OwnerViewController

- (void)viewDidLoad {
	AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	self.moc = delegate.managedObjectContext;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self checkExistingTheme];
	[self initialLoadFromPlist];
	[self loadOwners];
	
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)onCustomizeButtonPressed:(id)sender {
	UIView *popUp = [[UIView alloc] initWithFrame:self.view.frame];
	
	UIStackView *stack = [[UIStackView alloc] initWithFrame:popUp.frame];
	
	[stack addArrangedSubview:[self createThemeButton:@"Red"]];
	[stack addArrangedSubview:[self createThemeButton:@"Blue"]];
	[stack addArrangedSubview:[self createThemeButton:@"Green"]];
	stack.axis = UILayoutConstraintAxisVertical;
	stack.distribution = UIStackViewDistributionFillEqually;
	popUp.backgroundColor = [UIColor blackColor];
	[popUp addSubview:stack];
	[self.view addSubview:popUp];
}

- (UIButton*)createThemeButton:(NSString*)title{
	UIButton *button = [[UIButton alloc] init];
	[button setTitle:title forState:UIControlStateNormal];
	[button addTarget:self action:@selector(changeThemeTo:) forControlEvents:UIControlEventTouchDown];
	return button;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnerCell"];
	
	Owner *owner = [self.owners objectAtIndex:indexPath.row];
	cell.textLabel.text = owner.name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	[self performSegueWithIdentifier:@"OwnerProperties" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([segue.identifier isEqualToString:@"OwnerProperties"]){
		PropertiesViewController *destination = segue.destinationViewController;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		Owner *owner = [self.owners objectAtIndex:indexPath.row];
		destination.owner = owner;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.owners.count;
}

- (void)loadOwners{
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
	
	NSError *error;
	
	self.owners = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
	[self.tableView reloadData];
	
}

- (void)initialLoadFromPlist{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if (![defaults objectForKey:@"dataImported"]) {
		
		NSError *errorDesc = nil;
		NSPropertyListFormat format;
		NSString    *path = [[NSBundle mainBundle] pathForResource:@"ownerList" ofType:@"plist"];
		NSData      *plistXML = [[NSFileManager defaultManager] contentsAtPath:path];
		NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
																					propertyListWithData:plistXML
																					options:NSPropertyListMutableContainersAndLeaves
																					format:&format
																					error:&errorDesc];
		for (NSString *key in temp){
			Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.moc];
			NSDictionary *value = temp[key];
			owner.name = value[@"name"];
		}
		[defaults setObject:@"OK" forKey:@"dataImported"];
		[defaults synchronize];
		[self.moc save:&errorDesc];
	}
}

#pragma mark - theme specific methods

-(void)changeThemeTo:(UIButton*)sender{
	NSString *title = sender.titleLabel.text;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ([title isEqualToString:@"Red"]){
		[self changeThemeForAllItems:[UIColor redColor]];
		[defaults setObject:@"red" forKey:@"themeColor"];
	} else if ([title isEqualToString:@"Blue"]){
		[self changeThemeForAllItems:[UIColor blueColor]];
		[defaults setObject:@"blue" forKey:@"themeColor"];
	} else if ([title isEqualToString:@"Green"]){
		[self changeThemeForAllItems:[UIColor greenColor]];
		[defaults setObject:@"green" forKey:@"themeColor"];
	}
	
	[sender.superview.superview removeFromSuperview];
}

- (void)changeThemeForAllItems:(UIColor*)color{
	self.navigationController.navigationBar.tintColor = color;
}


- (void)checkExistingTheme{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *color = [defaults objectForKey:@"themeColor"];
	if ([defaults objectForKey:@"themeColor"]) {
		if ([color isEqualToString:@"blue"]){
			[self changeThemeForAllItems:[UIColor blueColor]];
		} else if ([color isEqualToString:@"green"]){
			[self changeThemeForAllItems:[UIColor greenColor]];
		} else if ([color isEqualToString:@"red"]){
			[self changeThemeForAllItems:[UIColor redColor]];
		}
	}
}

@end
