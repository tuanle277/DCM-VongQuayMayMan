#import "Segment.h"

@implementation Segment

- (id) initWithColor: (UIColor *) newColor andValue: (CGFloat) newValue
{
    self = [super init];
    if (self)
    {
        self.color = newColor;
        self.value = newValue;
    }
    return self;
}

@end
