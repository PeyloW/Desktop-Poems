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
    
    // Vi anropar f�r�lder klassen men s�ger att vi inte ska ha en namnlist
    NSWindow* result = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    
    // V�r bakgrundf�rg �r genomskinlig
    [result setBackgroundColor:[NSColor clearColor]];
    
    // Vi ska sv�va �verst
    [result setLevel: NSStatusWindowLevel];
    
    // Sl� p� m�jlighet till genomskinlighet
    [result setOpaque:NO];
    
    // Och sl� p� v�r skugga!
    [result setHasShadow: YES];
    return result;
}

// Utan denna kan inte namnlistl�sa f�nster f� fokus
- (BOOL) canBecomeKeyWindow
{
    return YES;
}

// �verlagra f�r att flytta runt f�nstret lite
- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint currentLocation;
    NSPoint newOrigin;
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    NSRect  windowFrame = [self frame];
    
    // Var �r musen nu?
    currentLocation = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream]];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Inte dras in under menyraden tack
    if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
        newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
    }
    
    // Tjosan, s� flyttar vi
    [self setFrameOrigin:newOrigin];
}

// Vi antar att g�r musen ned s� ska h�r flyttas
- (void)mouseDown:(NSEvent *)theEvent
{    
    if ([theEvent clickCount] > 1) {
        [controller close];
    } else {
        
        NSRect  windowFrame = [self frame];
        // S� spara kordinaterna f�r senare.
        initialLocation = [self convertBaseToScreen:[theEvent locationInWindow]];
        initialLocation.x -= windowFrame.origin.x;
        initialLocation.y -= windowFrame.origin.y;
    }
}

@end
