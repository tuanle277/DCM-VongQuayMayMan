#import "VongQuay.h"
#import "VePhanVongQuay.h"
#import "PhanVongQuay.h"
#import "Segment.h"

@interface VongQuay()

@end

@implementation VongQuay

#define PI 3.14

@synthesize diameter = _diameter;
@synthesize circle = _circle;
@synthesize indicator = _indicator;
@synthesize radius = _radius;
@synthesize numberOfSectors = _numberOfSectors;
@synthesize colors = _colors;
@synthesize rewards = _rewards;
@synthesize arrayOfSectors = _arrayOfSectors;
@synthesize timer = _timer;
@synthesize spinTime = _spinTime;
@synthesize circleRotationInRadian = _circleRotationInRadian;

- (id) initWithFrame:(CGRect)frame
 withSections:(int)sectionsNumber withDiameter:(int)diameter
{
    self = [super initWithFrame: frame];
    self.diameter = diameter;
    self.radius = diameter / 2;
    self.numberOfSectors = sectionsNumber;
    [self configureVariables];
    [self buildCircle];
    return self;
}

- (void) configureVariables
{
    // danh sách giải thưởng
    self.rewards = [NSMutableArray arrayWithObjects:@"Thẻ nạp 1", @"Thẻ nạp 2", @"Thẻ nạp 3", @"Thẻ nạp 4", @"Thẻ nạp 5", @"Thẻ nạp 6", @"Thẻ nạp 7", @"Thẻ nạp 8", nil];
    
    // danh sách màu từng phần vòng quay
    self.colors = [NSMutableArray arrayWithObjects: UIColor.blackColor, UIColor.blueColor, UIColor.yellowColor, UIColor.whiteColor, UIColor.greenColor, UIColor.grayColor, UIColor.orangeColor, UIColor.whiteColor, nil];
}

- (void) buildCircle
{
    self.circle = [[UIView alloc] initWithFrame:  CGRectMake((self.frame.size.width - self.diameter) / 2, 400, self.radius * 2, self.radius * 2)];
    self.circle.layer.cornerRadius = self.radius;
    self.circle.backgroundColor = UIColor.whiteColor;
    
    // Tạo các phần của vòng quay
    VePhanVongQuay *sectors = [[VePhanVongQuay alloc] init];
    sectors.startAngle = -PI - 2 * PI / self.numberOfSectors / 2;
    sectors.radius = self.radius;
    sectors.frame = self.circle.bounds;
    sectors.arrayOfSegments = [NSMutableArray array];
    
    for (int i = 0; i < self.numberOfSectors; i++)
    {
        [sectors.arrayOfSegments addObject: [[Segment alloc] initWithColor: self.colors[i] andValue:40]];
    }
    
    self.indicator = [[UIView alloc] initWithFrame:CGRectMake(10, 575, (self.frame.size.width - self.diameter) / 2 - 10, 1)];
    self.indicator.backgroundColor = UIColor.whiteColor;
    
    [self.circle addSubview: sectors];
    [self buildItems];
    [self buildSectors];
}
    
- (void) buildItems
{
    // make items (UILabel)
    for (int i = 0; i < self.numberOfSectors; i++) {
        UILabel *word = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.radius, 70)];
        word.text = self.rewards[i];
        word.font = [UIFont fontWithName: @"Times new roman" size: 30];
        if (i <= 1)
        {
            word.textColor = UIColor.whiteColor;
        }
        else
        {
            word.textColor = UIColor.blackColor;
        }
        word.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        word.layer.position = CGPointMake(self.circle.bounds.size.width/2.0, self.circle.bounds.size.height/2.0);
        word.transform = CGAffineTransformMakeRotation(PI * 2 / self.numberOfSectors * i);
        [self.circle addSubview: word];
    }
}

- (void) buildSectors
{
    // Độ dài quạt
    CGFloat sectorLength = PI*2/self.numberOfSectors;
    // initial midpoint
    CGFloat mid = 0;
    // Tạo từng phần của vòng quay (item) và đưa vào mảng chứa các items
    for (int i = 0; i < self.numberOfSectors; i++)
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
        [self.arrayOfSectors addObject:sector];
    }
}

- (void) buildUpRotation
{
    CGAffineTransform t = CGAffineTransformRotate(self.circle.transform, -PI * 2);
    self.circle.transform = t;
    self.timer = [NSTimer scheduledTimerWithTimeInterval: self.spinTime target:self
                                    selector:@selector(buildUpRotation)
                                   userInfo:nil
                                    repeats:NO];
    [self updateUp];
}

- (void) updateUp
{
    [self.timer invalidate];
    CGAffineTransform t = CGAffineTransformRotate(self.circle.transform, -PI * 2);
    self.circle.transform = t;
    self.spinTime -= 0.00002;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.spinTime target:self selector:@selector(updateUp) userInfo:nil repeats:NO];
}

- (void) turnOffRotation
{
    CGAffineTransform t = CGAffineTransformRotate(self.circle.transform, -PI * 2);
    self.circle.transform = t;
    self.timer = [NSTimer scheduledTimerWithTimeInterval: self.spinTime target:self
                                    selector:@selector(turnOffRotation)
                                   userInfo:nil
                                    repeats:NO];
    [self updateDown];
}


- (void) updateDown
{
    [self.timer invalidate];
    CGAffineTransform t = CGAffineTransformRotate(self.circle.transform, -PI * 2);
    self.circle.transform = t;
    self.spinTime += 0.00003;
    if (self.spinTime < 0.01f)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.spinTime target:self selector:@selector(updateDown) userInfo:nil repeats:NO];
    }
    else
    {
        [self.timer invalidate];
        CGFloat radians = atan2f(self.circle.transform.b, self.circle.transform.a);
        CGFloat newVal = 0.0;
        for (PhanVongQuay *s in self.arrayOfSectors) {
            if (radians > s.lowerBound && radians < s.higherBound) {
                newVal = radians - s.mid;
                break;
            }
        }
        
        CGAffineTransform t = CGAffineTransformRotate(self.circle.transform, -newVal);
        self.circle.transform = t;
        self.self.circleRotationInRadian = atan2f(self.circle.transform.b, self.circle.transform.a);
        NSLog (@"actual rotation is %f", self.circleRotationInRadian);
//        [self configureWinningAlert: [rewards objectAtIndex: [self getTag: circleRotationInRadian]]];
//        [self presentViewController: prizeAlert animated:YES completion:nil];
//        lanQuay -= 1;
//        self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
    }
}




@end
