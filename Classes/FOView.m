#import "FOView.h"

@implementation FOView

static NSImage *leftImage = nil, *rightImage = nil, *middleImage = nil;

+ (void)initialize
{
  leftImage = [NSImage imageNamed:@"left"];
  rightImage = [NSImage imageNamed:@"right"];
  middleImage = [NSImage imageNamed:@"middle"];
}

- (void)setAlignableLeft:(BOOL)left right:(BOOL) right {
    isLeftAlignable = left;
    isRightAlignable = right;
};


-(void)drawRect:(NSRect)rect
{
    NSRect myFrame, middleFrame;

    myFrame = [self frame];
    middleFrame = myFrame;
    middleFrame.origin.y = 0.0;
    
    // Radera bakgrund 
    [[NSColor clearColor] set];
    NSRectFill(myFrame);

    // Rita vänster
    if(!isLeftAlignable) {
        [leftImage compositeToPoint:NSZeroPoint operation:NSCompositeSourceOver];
        middleFrame.origin.x = 10.0;
        middleFrame.size.width -= 10.0;
        
    }
    
    if(!isRightAlignable) {
        [rightImage compositeToPoint:(NSPoint){myFrame.size.width - 10, 0.0} operation:NSCompositeSourceOver];
        middleFrame.size.width -= 10;
    }
    
    [middleImage drawInRect:middleFrame fromRect:(NSRect){{0.0, 0.0}, [middleImage size]} operation:NSCompositeSourceOver fraction: 1.0];

    // Fixa till en ny skugga
    if (!hasCalculatedShadow) {
        hasCalculatedShadow = YES;
        [[self window] invalidateShadow];
    }
}

@end
