//
//  FlickrList.m
//  Principia
//
//  Created by Dennis on 3/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FlickrList.h"
#import "GlobalUtil.h"
#import "FlickrShow.h"
#import "TouchXML.h"
#import "SMWebRequest.h"

@implementation FlickrList
@synthesize FlList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/**************************************************************************/
#pragma mark - Flickr Parsing
//Prin Flickr ID - 66225587@N07
-(void)ParseFlickr:(NSData *)data
{
    CXMLDocument *flickrxml = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *nodes = [flickrxml nodesForXPath:@"//photoset" error:nil];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for(CXMLElement *node in nodes)
    {
        NSMutableDictionary *flickritem;
        flickritem = [[NSMutableDictionary alloc] init];
        [flickritem setObject:[[node attributeForName:@"id"] stringValue] forKey:@"link"];
        [flickritem setObject:[[node attributeForName:@"photos"] stringValue] forKey:@"count"];
        [flickritem setObject:[[node childAtIndex:1] stringValue] forKey:@"title"];
        [list addObject:flickritem];
        
    }
    
    FlList = list;
    [self.tableView reloadData];
}

-(void)LoadFlickrRequest
{
    NSURL *flurl = [[NSURL alloc] initWithString:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=a79b1b16d5f70f76dbe314ff37fb5c75&user_id=66225587%40N07&page=1&per_page=25&format=rest"];
    SMWebRequest *request = [SMWebRequest requestWithURL:flurl];
    [request addTarget:self action:@selector(ParseFlickr:) forRequestEvents:SMWebRequestEventComplete];
    [request addTarget:self action:@selector(requestError) forRequestEvents:SMWebRequestEventError];
    [request start];
}

/********************************************************************************************/
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refreshView)
                  forControlEvents:UIControlEventValueChanged];
    [self LoadFlickrRequest];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self LoadFlickrRequest];
}

-(void)refreshView
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return FlList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FlickrCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    }
    
    // Configure the cell...
    NSMutableDictionary *item = [FlList objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ photos",[item objectForKey:@"count"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowGal"])
    {
        NSIndexPath *row = self.tableView.indexPathForSelectedRow;
        NSString *link = [[FlList objectAtIndex:row.row] objectForKey:@"link"];
        FlickrShow *dest = [segue destinationViewController];
        [dest LinkaddrAs:link];
        dest.navigationController.navigationBar.topItem.title = [[FlList objectAtIndex:row.row] objectForKey:@"title"];
        
        
        
    }
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
