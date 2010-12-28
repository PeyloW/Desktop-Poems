/* MyFloater */

#import <Cocoa/Cocoa.h>
#import "FOFloaterController.h"

@interface FOFloater : NSWindow
{
    IBOutlet FOFloaterController *controller;
    IBOutlet NSTextField *textField;
    NSPoint initialLocation;
}
@end
