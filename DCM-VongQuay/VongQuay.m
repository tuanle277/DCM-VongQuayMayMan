#import "VongQuay.h"
#import "VePhanVongQuay.h"
#import "PhanVongQuay.h"
#import "Segment.h"

@interface VongQuay()

@end

@implementation VongQuay

#define PI 3.141

@synthesize diameter;
@synthesize circle;
@synthesize indicator;
@synthesize radius;
@synthesize numberOfSectors;
@synthesize colors;
@synthesize rewards;
@synthesize arrayOfSectors;
@synthesize timer;
@synthesize spinTime;
@synthesize circleRotationInRadian;

- (id) initWithFrame:(CGRect)frame
 withSections:(int)sectionsNumber withDiameter:(int)diameter
{
    self = [super initWithFrame: frame];
    self.diameter = diameter;
    self.radius = diameter / 2;
    self.numberOfSectors = sectionsNumber;
    return self;
}

- (void) buildCircle
{
    circle = [[UIView alloc] initWithFrame: CGRectMake((self.frame.size.width - diameter) / 2, 400, radius * 2, radius * 2)];
    circle.layer.cornerRadius = radius;
    circle.backgroundColor = UIColor.whiteColor;
    
    // Tạo các phần của vòng quay
    VePhanVongQuay *sectors = [[VePhanVongQuay alloc] init];
    sectors.startAngle = -PI - 2 * PI / numberOfSectors / 2;
    sectors.radius = radius;
    sectors.frame = circle.bounds;
    sectors.arrayOfSegments = [NSMutableArray array];
    
    for (int i = 0; i < numberOfSectors; i++)
    {
        [sectors.arrayOfSegments addObject: [[Segment alloc] initWithColor: colors[i] andValue:40]];
    }
    
    indicator = [[UIView alloc] initWithFrame:CGRectMake(10, 575, (self.frame.size.width - diameter) / 2 - 10, 1)];
    indicator.backgroundColor = UIColor.whiteColor;
    
//    [self.view addSubview: circle];
    [circle addSubview: sectors];
//    [self.view addSubview: indicator];
//    UIImageView *wheelBG = [[UIImageView alloc] initWithFrame: circle.frame];
//    wheelBG.image = [UIImage imageNamed: @"Fortune-wheel.png"];
//    [self.view addSubview: wheelBG];
    [self buildItems];
    [self buildSectors];
}
    
- (void) buildItems
{
    // make items (UILabel)
    for (int i = 0; i < numberOfSectors; i++) {
        UILabel *word = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, radius, 70)];
        word.text = rewards[i];
        word.font = [UIFont fontWithName: @"Times new roman" size: 30];
        word.textColor = UIColor.whiteColor;
        word.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        word.layer.position = CGPointMake(circle.bounds.size.width/2.0,circle.bounds.size.height/2.0);
        word.transform = CGAffineTransformMakeRotation(PI * 2 / numberOfSectors * i);
        [circle addSubview: word];
}
}

- (void) buildSectors
{
    // Độ dài quạt
    CGFloat sectorLength = PI*2/numberOfSectors;
    // initial midpoint
    CGFloat mid = 0;
    // Tạo từng phần của vòng quay (item) và đưa vào mảng chứa các items
    for (int i = 0; i < numberOfSectors; i++)
    {
        PhanVongQuay *sector = [[PhanVongQuay alloc] init];
        sector.mid = mid;
        sector.lowerBound = mid - (sectorLength/2);
        sector.higherBound = mid + (sectorLength/2);
        sector.tag = i;
        if (sector.higherBound-sectorLength < -PI)
        {
            mid = PI;
            sector.mid  = mid;
            sector.lowerBound = fabsf(sector.higherBound);
        }
        mid -= sectorLength;
        NSLog(@"%f %f %f", sector.lowerBound, sector.mid, sector.higherBound);
        // Add sector to array
        [arrayOfSectors addObject:sector];
    }
}

- (void) buildUpRotation
{
    CGAffineTransform t = CGAffineTransformRotate(circle.transform, -PI * 2);
    circle.transform = t;
    timer = [NSTimer scheduledTimerWithTimeInterval: spinTime target:self
                                    selector:@selector(buildUpRotation)
                                   userInfo:nil
                                    repeats:NO];
    [self updateUp];
}

- (void) updateUp
{
    [timer invalidate];
    CGAffineTransform t = CGAffineTransformRotate(circle.transform, -PI * 2);
    circle.transform = t;
    spinTime -= 0.00002;
    timer = [NSTimer scheduledTimerWithTimeInterval:spinTime target:self selector:@selector(updateUp) userInfo:nil repeats:NO];
}

- (void) turnOffRotation
{
    CGAffineTransform t = CGAffineTransformRotate(circle.transform, -PI * 2);
    circle.transform = t;
    timer = [NSTimer scheduledTimerWithTimeInterval: spinTime target:self
                                    selector:@selector(turnOffRotation)
                                   userInfo:nil
                                    repeats:NO];
    [self updateDown];
}


- (void) updateDown
{
    [timer invalidate];
    CGAffineTransform t = CGAffineTransformRotate(circle.transform, -PI * 2);
    circle.transform = t;
    spinTime += 0.00003;
    if (spinTime < 0.01f)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:spinTime target:self selector:@selector(updateDown) userInfo:nil repeats:NO];
    }
    else
    {
        [timer invalidate];
        CGFloat radians = atan2f(circle.transform.b, circle.transform.a);
        CGFloat newVal = 0.0;
        for (PhanVongQuay *s in arrayOfSectors) {
            if (radians > s.lowerBound && radians < s.higherBound) {
                newVal = radians - s.mid;
                break;
            }
        }
        
        CGAffineTransform t = CGAffineTransformRotate(circle.transform, -newVal);
        circle.transform = t;
        self.circleRotationInRadian = atan2f(circle.transform.b, circle.transform.a);
        NSLog (@"actual rotation is %f", circleRotationInRadian);
//        [self configureWinningAlert: [rewards objectAtIndex: [self getTag: circleRotationInRadian]]];
//        [self presentViewController: prizeAlert animated:YES completion:nil];
//        lanQuay -= 1;
//        self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
    }
}




@end
