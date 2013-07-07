//
//  MealCard2.h
//  Principia
//
//  Created by Dale Matheny on 2/28/13.
//
//

#import <UIKit/UIKit.h>

@class TransformView;

@interface MealCard : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet TransformView *transformView;
@property (weak, nonatomic) IBOutlet UIImageView *discView;

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIImageView *Barcode;
@property (nonatomic, retain) IBOutlet UIImageView *StudentID;
@property (nonatomic, retain) IBOutlet UIImageView *Security;

- (IBAction)updatePressed:(id)sender;

@end