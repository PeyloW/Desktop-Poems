//  FOFloater.m
//  Desktop Poems
//
//  Copyright 2003-2011 Fredrik Olsson. All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
#import "FOFloater.h"

@implementation FOFloater

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    
    // Vi anropar fšrŠlder klassen men sŠger att vi inte ska ha en namnlist
    NSWindow* result = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    
    // VŒr bakgrundfŠrg Šr genomskinlig
    [result setBackgroundColor:[NSColor clearColor]];
    
    // Vi ska svŠva šverst
    [result setLevel: NSStatusWindowLevel];
    
    // SlŒ pŒ mšjlighet till genomskinlighet
    [result setOpaque:NO];
    
    // Och slŒ pŒ vŒr skugga!
    [result setHasShadow: YES];
    return result;
}

// Utan denna kan inte namnlistlšsa fšnster fŒ fokus
- (BOOL) canBecomeKeyWindow
{
    return YES;
}

// …verlagra fšr att flytta runt fšnstret lite
- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint currentLocation;
    NSPoint newOrigin;
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    NSRect  windowFrame = [self frame];
    
    // Var Šr musen nu?
    currentLocation = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream]];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Inte dras in under menyraden tack
    if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
        newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
    }
    
    // Tjosan, sŒ flyttar vi
    [self setFrameOrigin:newOrigin];
}

// Vi antar att gŒr musen ned sŒ ska hŠr flyttas
- (void)mouseDown:(NSEvent *)theEvent
{    
    if ([theEvent clickCount] > 1) {
        [controller close];
    } else {
        
        NSRect  windowFrame = [self frame];
        // SŒ spara kordinaterna fšr senare.
        initialLocation = [self convertBaseToScreen:[theEvent locationInWindow]];
        initialLocation.x -= windowFrame.origin.x;
        initialLocation.y -= windowFrame.origin.y;
    }
}

@end
