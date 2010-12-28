//  FOMenuController.h
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

#import <Cocoa/Cocoa.h>

@interface FOMenuController : NSObject
{
    IBOutlet NSMenu *menu;
    IBOutlet NSMenu *opacityMenu;
    NSMutableArray *myFloaters;
    NSMutableArray *words;
    float opacity;
}
- (IBAction)clearWordlist:(id)sender;
- (IBAction)closeWords:(id)sender;
- (IBAction)newWords:(id)sender;
- (IBAction)openWordlist:(id)sender;
- (IBAction)setOpacity:(id)sender;

- (void)createNewWord;
- (void)addWordsFromFile:(NSString*)fileName;

@end
