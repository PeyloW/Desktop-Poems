//  FOMenuController.m
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

#import "FOMenuController.h"
#import "FOFloaterController.h"

#include <stdlib.h>
#include <stdio.h>

@implementation FOMenuController

// Instantiates a new worldlist and polulates it with a selected number of default words
- (IBAction)clearWordlist:(id)sender
{
    words = [NSMutableArray arrayWithCapacity: 0];
    [words addObject: @"Macintosh_"]; 
    [words addObject: @"toys_"];
    [words addObject: @"Apple_"];
}


- init {
    self = [super init];
    if(!self) return nil;
    
    opacity = 0.85;
    
    myFloaters = [NSMutableArray arrayWithCapacity: 0];

    [self clearWordlist: self];

    [self addWordsFromFile: [[NSBundle bundleForClass: [self class]] pathForResource: @"words" ofType: @"txt"]];  
    
    srandom(floor([NSDate timeIntervalSinceReferenceDate]));
    
    return self;
}

- (void)createNewWord {
    NSString *word;
    int i;
    NSPoint newOrigin;
    
    FOFloaterController *newFloater;
    
    i = [words count];
    i = random() % i;
    word = [words objectAtIndex: i];
    
    newFloater = [[FOFloaterController alloc] initWithMenuController:self];
    if (![NSBundle loadNibNamed: @"FOFloater" owner: newFloater]) {
        NSLog(@"Error loading Nib for document!");
    } else {
        [newFloater setText: word];
        newOrigin.x = [[NSScreen mainScreen] frame].size.width;
        newOrigin.x = newOrigin.x / 4 + random() % (int)(newOrigin.x / 2);
        newOrigin.y = [[NSScreen mainScreen] frame].size.height;
        newOrigin.y = newOrigin.y / 4 + random() % (int)(newOrigin.y / 2);
        [[newFloater window] setFrameOrigin: newOrigin]; 
        [[newFloater window] setAlphaValue: opacity];
        [[newFloater window] makeKeyAndOrderFront: self];
        [myFloaters addObject: newFloater];
    }
}

- (IBAction)closeWords:(id)sender
{
    FOFloaterController *tempFloater = nil;
    if([sender tag] == 1) {
        if([NSApp keyWindow] !=nil) {
            [myFloaters removeObjectIdenticalTo: [[NSApp keyWindow] windowController]];
            [[[NSApp keyWindow] windowController] close]; 
        }
    } else {
        for(tempFloater in myFloaters) {
            [tempFloater close];
        }
        [myFloaters removeAllObjects];
    }
}

- (IBAction)newWords:(id)sender
{
    int i;
    for(i = 0; i < [sender tag]; i++)
        [self createNewWord];
}

- (void)addWordsFromFile:(NSString*)fileName {
    NSArray *newWords;
    
    newWords = [[NSString stringWithContentsOfFile: fileName] componentsSeparatedByString: @","];
    
    for(id loopItem in newWords)
        [words addObject: [loopItem stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];

}


- (IBAction)openWordlist:(id)sender
{
    int result;
    NSArray *fileTypes = [NSArray arrayWithObject:@"txt"];
    NSOpenPanel *oPanel = [NSOpenPanel openPanel];

    [oPanel setAllowsMultipleSelection:YES];
    result = [oPanel runModalForDirectory:NSHomeDirectory() file:nil types:fileTypes];
    if (result == NSOKButton) {
        NSArray *filesToOpen = [oPanel filenames];
        for (id loopItem in filesToOpen) {
            [self addWordsFromFile: loopItem];
        }
    }
}

- (IBAction)setOpacity:(id)sender
{
    int i;
    FOFloaterController *anObject;
    
    for(i = 0; i < 5; i++)
        [[opacityMenu itemAtIndex: i] setState: NSOffState];
    [sender setState: NSOnState];
    opacity = [sender tag] / 100.0;

    for (anObject in myFloaters) {
        [[anObject window] setAlphaValue: opacity];
    }

}

@end
