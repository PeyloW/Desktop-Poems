#import "FOFloater.h"

@implementation FOFloater

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {

    // Vi anropar förälder klassen men säger att vi inte ska ha en namnlist
    NSWindow* result = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];

    // Vår bakgrundfärg är genomskinlig
    [result setBackgroundColor:[NSColor clearColor]];
    
    // Vi ska sväva överst
    [result setLevel: NSStatusWindowLevel];
    
    // Slå på möjlighet till genomskinlighet
    [result setOpaque:NO];
    
    // Och slå på vår skugga!
    [result setHasShadow: YES];
    return result;
}

// Utan denna kan inte namnlistlösa fönster få fokus
- (BOOL) canBecomeKeyWindow
{
    return YES;
}

// Överlagra för att flytta runt fönstret lite
- (void)mouseDragged:(NSEvent *)theEvent
{
   NSPoint currentLocation;
   NSPoint newOrigin;
   NSRect  screenFrame = [[NSScreen mainScreen] frame];
   NSRect  windowFrame = [self frame];

    // Var är musen nu?
    currentLocation = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream]];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Inte dras in under menyraden tack
    if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
	newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
    }
    
    // Tjosan, så flyttar vi
    [self setFrameOrigin:newOrigin];
}

// Vi antar att går musen ned så ska här flyttas
- (void)mouseDown:(NSEvent *)theEvent
{    
    NSRect  windowFrame = [self frame];

    // Så spara kordinaterna för senare.
   initialLocation = [self convertBaseToScreen:[theEvent locationInWindow]];
   initialLocation.x -= windowFrame.origin.x;
   initialLocation.y -= windowFrame.origin.y;
}

@end
