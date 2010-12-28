//  FOFloaterController.m
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
