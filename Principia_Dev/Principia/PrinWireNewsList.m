//
//  PrinWireNewsList.m
//  Principia
//
//  Created by Dennis on 3/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PrinWireNewsList.h"
#import "GlobalUtil.h"
#import "WireViewer.h"
#import "TouchXML.h"
#import "SMWebRequest.h"

@implementation PrinWireNewsList
@synthesize List;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //Add the back and foward buttons that are at the top right of the screen. These are
        //segment controls with images in them
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
												[NSArray arrayWithObjects:
												 [UIImage imageNamed:@"icon_left.png"],
												 [UIImage imageNamed:@"icon_play.png"],
												 nil]];
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
		segmentedControl.frame = CGRectMake(0, 0, 60, kCustomButtonHeight);
		segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
		segmentedControl.momentary = YES;
		
		UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
		
		self.navigationItem.rightBarButtonItem = segmentBarItem;
		
		// Tells the webView to load pdfUrl
		[self performSelector:@selector(processURL) withObject:NULL afterDelay:0.0];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return List.count;
}

/**
 * Method name: getTextHeight
 * Description: determines the height that a specific amount of text in cellview of the tableview would take.
 * Parameters: arow: the index of the text in the List object to be analyzed.
 */

-(int)getTextHeight:(int)arow {
    
    NSDictionary *rowdata = [List objectAtIndex:arow];
    int width=250;
    if ((self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft) || (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight))
        width=415;
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [[rowdata objectForKey:@"description"] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:(CGFloat)13] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger aindex = ([indexPath section]*10)+[indexPath row];
    int height=[self getTextHeight :aindex];
    // NSLog( @"heightForRowAtIndexPath aindex: %d, row: %d, height: %d", aindex, [indexPath row],height);
    return height+40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WireCell";      //get the name of the custom cell for Prinwire
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WireCell" owner:self options:nil] lastObject];

    }
    
    // Configure the cell...
    NSMutableDictionary *item = [List objectAtIndex:indexPath.row];
    [(UILabel *)[cell viewWithTag:1] setText:[item objectForKey:@"title"]];         //add the title to the cell
    
    UILabel *alab=(UILabel *)[cell viewWithTag:2];
    [alab setText:[item objectForKey:@"description"]];          //add the description to the cell.
    alab.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect aframe=alab.frame;
    aframe.size.height=[self getTextHeight :[indexPath row]];
    [alab setFrame:aframe];

    //cell.detailTextLabel.text = [item objectForKey:@"description"];
    
    return cell;
}

/***********************************************************************/
#pragma mark - PrinWire Parsing
/**
 * Method name: ParsePrinWire
 * Description: Creates an xml document from web request data and then collects information
                from the college's prinwire. It gets information on the title of the article
                link of the article and a brief description.
 * Parameters: data -> parameter already has the web request information that needs to be parsed.
 */

-(void)ParsePrinWire:(NSData *)data
{
    CXMLDocument *wirexml = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *nodes = [wirexml nodesForXPath:@"//item" error:nil];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSMutableDictionary *entry;
    for(CXMLElement *node in nodes)
    {
        entry = [[NSMutableDictionary alloc] init];
        for (int index = 0; index<[node childCount]; index++) {
            NSLog(@"%@", [[node childAtIndex:index] stringValue]);              //output what has been received
        }
        [entry setObject:[[node childAtIndex:1] stringValue] forKey:@"title"];
        [entry setObject:[[node childAtIndex:3] stringValue] forKey:@"link"];
        
        //This code snippet tests each item in an xml element. It first finds out if it has
        //a unit character that all description items have. After that, it removes a specific
        //set of characters from the screen so that it can be more reada
        for (int secindex = 4; secindex<[node childCount]; secindex++) {
            NSString *teststring = [[node childAtIndex:secindex]stringValue];
            
            if([teststring rangeOfString:@"…"].location != NSNotFound)
            {
                
                NSRange range = [teststring rangeOfString:@"<a"];
                teststring = [teststring substringToIndex:range.location];
                [entry setObject:teststring forKey:@"description"];
                break;
            }
        }
        [list addObject:entry];
    }    
    List = list;
    [self.tableView reloadData];
}

/**
 * Method name: LoadPrinWireRequest
 * Description: Sets up a web request to fetch data from the Principia College's 
                PrinWire section.
 * Parameters: None
 */

-(void)LoadPrinWireRequest
{
    NSURL *flurl = [[NSURL alloc] initWithString:
                    /*@"http://www.principiawire.com/category/college/feed/"];*/
    @"http://www.principiawire.com/category/college/feed/"];
    SMWebRequest *request = [SMWebRequest requestWithURL:flurl];
    [request addTarget:self action:@selector(ParsePrinWire:) forRequestEvents:SMWebRequestEventComplete];
    [request addTarget:self action:@selector(requestError) forRequestEvents:SMWebRequestEventError];
    [request start];
}
/***************************************************************************/

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [self LoadPrinWireRequest];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refreshView)
                        forControlEvents:UIControlEventValueChanged];
    [self LoadPrinWireRequest];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)refreshView
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier: @"ViewArticle" sender: indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"ViewArticle" sender: indexPath];    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ViewArticle"])
    {
        NSIndexPath *row = sender;
        NSString *link = [[List objectAtIndex:row.row] objectForKey:@"link"];
        WireViewer *view = [segue destinationViewController];
        [view addAddr:link];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
