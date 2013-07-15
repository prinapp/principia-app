//
//  AppDelegate.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "utils.h"
#define kFilename @"PrinDB.sqlite"

#define prinserverMeals @"http://prinapp.geektron.me/requests/getmeal.php"
#define prinserverContacts @"http://prinapp.geektron.me/requests/getcontacts411.php"
#define prinserverCourseDetail @"http://prinapp.geektron.me/requests/courseDetail.php?crn=%d"
#define prinWebPics @"http://prinweb.prin.edu%@"
#define prinWebSearch @"http://prinweb.prin.edu/hagus/index.php3?eDir_search=%@&campus_search=elsah&gobutton=++++Search++++"
#define prinserverCourseSearch @"http://prinapp.geektron.me/requests/coursesearch.php?search=%@&term=%@"
#define prinserverCourseTerms @"http://prinapp.geektron.me/requests/getTerms.php"
#define prinserverPIR @"http://prinedu.ic.llnwd.net/stream/prinedu_stream.pls"
#define googleCalendar1 @"https://www.google.com/calendar/embed?title=Principia+Calendar&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=700&wkst=1&bgcolor=%23FFFFFF&src=um6hc1bmkugq2d2v4dcbp31d8o@group.calendar.google.com&color=%23528800&ctz=America/Chicago"
#define googleCalendar2 @"https://www.google.com/calendar/embed?title=Principia+Calendar&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=700&wkst=1&bgcolor=%23FFFFFF&src=in7c6001nutaocbf5cualpqa3k@group.calendar.google.com&color=%23B1440E&src=n6ppjvn6igqtec621r9rt0s8go@group.calendar.google.com&color=%23B1365F&src=1mbqj0g8ui5idqlrq53qr0bido@group.calendar.google.com&color=%2328754E&src=u3p3m60u9141dcsma1j10pa5p8@group.calendar.google.com&color=%231B887A&ctz=America/Chicago"
#define googleCalendar3 @"https://www.google.com/calendar/embed?title&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=300&wkst=1&bgcolor=%23FFFFFF&src=in7c6001nutaocbf5cualpqa3k@group.calendar.google.com&color=%23B1440E&src=n6ppjvn6igqtec621r9rt0s8go@group.calendar.google.com&color=%23B1365F&src=1mbqj0g8ui5idqlrq53qr0bido@group.calendar.google.com&color=%2328754E&src=bm2l8vb0603ft7t0f4k655jvao@group.calendar.google.com&color=%235229A3&src=u3p3m60u9141dcsma1j10pa5p8@group.calendar.google.com&color=%231B887A&src=um6hc1bmkugq2d2v4dcbp31d8o@group.calendar.google.com&color=%23528800&ctz=America/Chicago"
#define googleCalendar4 @""
#define flickerListURL @"http://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=a79b1b16d5f70f76dbe314ff37fb5c75&user_id=66225587%40N07&page=1&per_page=25&format=rest"
#define flickerURLSets @"http://www.flickr.com/photos/principiacollege/sets/"
#define flickerURL @"http://www.flickr.com/photos/principiacollege/sets/%@/show"
#define aboutPrin @"http://www.principiacollege.edu/about-principia-college"
#define suggestionForm @"https://docs.google.com/forms/d/1pGG6h2an68lU9XBguOX5RgWo3VjkoH6b7TkdLSWQBCQ/viewform"
#define prinserverMealDetail @"http://prinapp.geektron.me/requests/mealdescr.php"
#define prinFlashy @"http://prinweb.prin.edu/slider/rss/"
#define prinWire @"http://www.principiawire.com/category/college/feed/"
#define prinyouTube @"http://www.youtube.com/principiacollege"
#define prinFacebook @"https://www.facebook.com/Principia.College"
#define prinTwitter @"https://twitter.com/princollege"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UINavigationController *navController;      // Main Navigation controller
    sqlite3*database;                           // Main Database
    sqlite3*database2;                          // Backup Database just in case the main one is not there
    NSMutableArray *Flashylinks;                // List to store links for the flas
    utils *autil;                               // Utility for app
    NSMutableArray *tabData;                    // temp names
}

@property (nonatomic, retain) utils	*autil;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) UITabBarController *tabBarController;
-(NSString *) dataFilePath;                     //Method to open the database.
@end
