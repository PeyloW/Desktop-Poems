#import "FOFloaterController.h"

@implementation FOFloaterController

- (void)setText:(NSString *) text {
    // Fixa till så att _ och sådant ordnar sig
    NSRect newFrame;
    NSString *myText;
    BOOL isLeftAlignable, isRightAlignable;
    
    if([text characterAtIndex: 0] == '_') {
        myText = [text substringFromIndex: 1]; 
        isLeftAlignable = YES;
    } else {
        isLeftAlignable = NO;
        myText = [text substringFromIndex: 0];
    }
    if([myText characterAtIndex: [myText length] - 1] == '_') {
        myText = [myText substringToIndex: [myText length] - 1];
        isRightAlignable = YES;
    } else {
        isRightAlignable = NO;
    }
    
    [myView setAlignableLeft: isLeftAlignable right: isRightAlignable];
    
    [textField setStringValue: myText];
    [textField sizeToFit];
    
    newFrame = [textField frame];
    newFrame.size.height = 23;
    newFrame.origin.y = 2;
        
    if(isLeftAlignable) {
        newFrame.size.width += 0;
        newFrame.origin.x = 0;
    } else {
        newFrame.size.width += 8;
        newFrame.origin.x = 8;
    }
    if(isRightAlignable) {
        newFrame.size.width += 0;
    } else {
        newFrame.size.width += 8;
    }

    [[self window] setContentSize: newFrame.size];
    [textField setFrameOrigin: newFrame.origin];
    
    [[self window] display];
    
} 

- (void)close {
    [[self window] close];
    [self dealloc];
}

@end
