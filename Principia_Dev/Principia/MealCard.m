//
//  MealCard2.m
//  Principia
//
//  Created by Dale Matheny on 2/28/13.
//
//

#import "MealCard.h"

#import "TransformView.h"

@interface MealCard ()

@end

@implementation MealCard

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Meal Card", @"Meal Card");
        self.tabBarItem.image = [UIImage imageNamed:@"food"];
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0]; 
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)updatePressed:(id)sender {
    }
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
@end
