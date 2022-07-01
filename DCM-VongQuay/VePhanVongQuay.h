#import <UIKit/UIKit.h>
#import "Segment.h"

NS_ASSUME_NONNULL_BEGIN

@interface VePhanVongQuay : UIView

@property CGFloat radius;
@property CGFloat startAngle;
@property CGFloat endAngle;
@property UIColor *sectorColor;
@property NSMutableArray<Segment *> *arrayOfSegments;

@end

NS_ASSUME_NONNULL_END
