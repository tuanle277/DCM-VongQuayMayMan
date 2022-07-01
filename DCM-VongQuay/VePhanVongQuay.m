#import "VePhanVongQuay.h"

@implementation VePhanVongQuay


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setOpaque: false];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    CGPoint rectCenter = CGPointMake(rect.origin.x + self.radius, rect.origin.y + self.radius);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat totalValues = 0.0;
    
    for (int i = 0; i < self.arrayOfSegments.count; ++i)
    {
        totalValues += self.arrayOfSegments[i].value;
    }
    
    for (int i = 0; i < self.arrayOfSegments.count; ++i)
    {
        CGContextSetFillColorWithColor(context, [self.arrayOfSegments[i].color CGColor]);
        self.endAngle = self.startAngle + 2 * 3.14 * (self.arrayOfSegments[i].value / totalValues);
        CGContextMoveToPoint(context, rectCenter.x, rectCenter.y);
        CGContextAddArc(context, rectCenter.x, rectCenter.y, self.radius, self.startAngle, self.endAngle, false);
        CGContextFillPath(context);
        self.startAngle = self.endAngle;
    }
}


@end
