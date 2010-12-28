/* MyView */

#import <Cocoa/Cocoa.h>

@interface FOView : NSView
{
    BOOL isLeftAlignable, isRightAlignable;
    BOOL hasCalculatedShadow;
}
- (void)setAlignableLeft:(BOOL)left right:(BOOL) right;

@end
