/* MyMenuController */

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
