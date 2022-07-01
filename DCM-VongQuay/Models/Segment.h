#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Segment : NSObject

@property UIColor * color;
@property CGFloat value;

- (id) initWithColor: (UIColor *) newColor andValue: (CGFloat) newValue;

@end

NS_ASSUME_NONNULL_END
