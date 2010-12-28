/* MyFloaterController */

#import <Cocoa/Cocoa.h>
#import "FOView.h"

@interface FOFloaterController : NSWindowController
{
    IBOutlet FOView *myView;
    IBOutlet NSTextField *textField;
}
- (void)setText:(NSString *)text;
- (void)close;
@end
