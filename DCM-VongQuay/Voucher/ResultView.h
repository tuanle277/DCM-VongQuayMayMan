#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultView : UIView
- (id) initWithFrame: (CGRect) frame withTitle: (NSString *) titleString andMessage: (NSString *) messageString;
- (void) show;

@end

NS_ASSUME_NONNULL_END
