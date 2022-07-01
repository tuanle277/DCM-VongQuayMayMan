#import "ViewController.h"
#import "PhanVongQuay.h"
#import "VePhanVongQuay.h"
#import "Segment.h"
#import "VongQuay.h"

@interface VongQuayViewController ()

@end

@implementation VongQuayViewController
{
    UIView *circle;
    UIView *indicator;
    CGFloat circleRotationInRadian;
    VongQuay *vongQuay;
    NSTimer *timer;
    UILabel *im;
    NSMutableArray<PhanVongQuay *> *arrayOfSectors;
    NSMutableArray<NSString *> *rewards;
    CGFloat sectorLength;
    UIAlertController *prizeAlert;
    UIAlertController *voucherDecisionAlert;
    UIAlertController *voucherAlert;
    NSString *voucher;
    NSMutableArray *colors;
    int numberOfSectors;
    BOOL spinning;
    int diameter;
    int radius;
    float spinTime;
    int lanQuay;
}

#define PI 3.14


- (void) configureVariables
{
    lanQuay = 0;
    diameter = 350;
    radius = diameter / 2;
    numberOfSectors = 8;
    sectorLength = PI * 2 / numberOfSectors;
    arrayOfSectors = [[NSMutableArray alloc]init];
    
    // danh sách giải thưởng
    rewards = [NSMutableArray arrayWithObjects:@"Thẻ nạp 1", @"Thẻ nạp 2", @"Thẻ nạp 3", @"Thẻ nạp 4", @"Thẻ nạp 5", @"Thẻ nạp 6", @"Thẻ nạp 7", @"Thẻ nạp 8", nil];
    
    // danh sách màu từng phần vòng quay
    colors = [NSMutableArray arrayWithObjects: UIColor.blackColor, UIColor.blueColor, UIColor.yellowColor, UIColor.whiteColor, UIColor.greenColor, UIColor.grayColor, UIColor.orangeColor, UIColor.whiteColor, nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVariables];
    [self configureSpinButton];
//    vongQuay = [[VongQuay alloc] initWithFrame:self.view.frame
//                                 withSections:numberOfSectors withDiameter:diameter];
//    vongQuay.colors = colors;
//    vongQuay.rewards = rewards;
//    [vongQuay buildCircle];
//    arrayOfSectors = vongQuay.arrayOfSectors;
//    [self.view addSubview: vongQuay.circle];
//    [self.view addSubview: vongQuay.indicator];
    [self buildCircle];
}

- (void) configureSpinButton
{
    [self.spinBtn.layer setCornerRadius: 30.0];
    [self.spinBtn setClipsToBounds: TRUE];
    [self.spinBtn.layer setBorderWidth: 5.0];
    [self.spinBtn.layer setBorderColor: UIColor.yellowColor.CGColor];
}

- (void) configureWinningAlert: (NSString *) prize
{
    NSString *message = [NSString stringWithFormat:@"Bạn đã nhận được phần thưởng \r %@", prize];
    prizeAlert =  [UIAlertController alertControllerWithTitle:@"Chúc mừng" message: message
                                               preferredStyle:UIAlertControllerStyleAlert];
    [prizeAlert.view.layer setCornerRadius:50.0];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle: @"OK" style:UIAlertActionStyleDefault handler: nil];
    [prizeAlert addAction: actionOk];
}

- (void) configureVoucherAlert
{
    voucherAlert = [UIAlertController alertControllerWithTitle:@"Voucher" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionDongY = [UIAlertAction actionWithTitle:@"Đồng ý" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *_Nonnull action)
                                  {
        if (![[self->voucherAlert textFields][0].text isEqualToString: @""])
        {
            self->voucher = [self->voucherAlert textFields][0].text;
            [self configureVoucherDecision];
            [self presentViewController: self->voucherDecisionAlert animated:YES completion: nil];
        }
    }];
    
    [voucherAlert addTextFieldWithConfigurationHandler: ^(UITextField * _Nonnull nameTextField) {
        nameTextField.placeholder = @"Vui lòng nhập mã trò chơi";
    }];
    
    [voucherAlert addAction: actionDongY];
}

- (void) configureVoucherDecision
{
    NSString *voucherDecision;
    if ([voucher isEqualToString: @"voucher"])
    {
        voucherDecision = @"Chúc mừng bạn đã nhận được một lượt chơi";
        lanQuay += 1;
        self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
        
    }
    else
    {
        voucherDecision = @"Mã voucher không hợp lệ";
    }
    
    voucherDecisionAlert = [UIAlertController alertControllerWithTitle:@"" message: voucherDecision preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler:nil];
    
    [voucherDecisionAlert addAction: cancelBtn];
}

#pragma mark ConfigureButtons

- (IBAction)thuongAction:(UIButton *)sender
{
    NSLog(@"thuong");
}

- (IBAction)trungGiaiAction:(UIButton *)sender
{
    NSLog(@"trung giai");
}

- (IBAction)coCauAction:(UIButton *)sender
{
    NSLog(@"co cau");
}

- (IBAction)tangLuotQuayAction:(UIButton *)sender
{
    [self configureVoucherAlert];
    [self presentViewController: voucherAlert animated:YES completion:nil];
}

#pragma mark ConfigureLuckyWheel

// Building the wheel (needs partitioning)**
- (void) buildCircle
{
    
//    UIImageView *wheelBG = [[UIImageView alloc] initWithFrame: CGRectMake((self.view.frame.size.width - diameter - 120) / 2, 340, radius * 2 + 120, radius * 2 + 120)];
//    wheelBG.image = [UIImage imageNamed: @"Fortune-wheel.png"];
//    [self.view addSubview: wheelBG];
    
    // Tạo nền của vòng quay
    circle = [[UIView alloc] initWithFrame: CGRectMake((self.view.frame.size.width - diameter) / 2, 400, radius * 2, radius * 2)];
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

    indicator = [[UIView alloc] initWithFrame:CGRectMake(10, 575, (self.view.frame.size.width - diameter) / 2 - 10, 1)];
    indicator.backgroundColor = UIColor.whiteColor;
  
    [self.view addSubview: circle];
    [circle addSubview: sectors];
    [self.view addSubview: indicator];

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
        if (i <= 1)
        {
            word.textColor = UIColor.whiteColor;
        }
        else
        {
            word.textColor = UIColor.blackColor;
        }
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

#pragma mark spinAction

// Functions for spinning, accelerating, slowing down until stops the wheel
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
        circleRotationInRadian = atan2f(circle.transform.b, circle.transform.a);
        [self configureWinningAlert: [rewards objectAtIndex: [self getTag: circleRotationInRadian]]];
        [self presentViewController: prizeAlert animated:YES completion:nil];
        lanQuay -= 1;
        self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
    }
}

- (void) getSpinResult
{
    NSLog(@"get spin result first");
    circleRotationInRadian = vongQuay.circleRotationInRadian;
    NSLog (@"rotated %f", circleRotationInRadian);
    [self configureWinningAlert: [rewards objectAtIndex: [self getTag: circleRotationInRadian]]];
    [self presentViewController: prizeAlert animated:YES completion:nil];
    lanQuay -= 1;
    self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
}

- (int) getTag: (float) radian
{
    CGFloat newVal = 0.0;
    for (int i = 0; i < [arrayOfSectors count]; i ++)
    {
        if ((radian >= [arrayOfSectors objectAtIndex: i].lowerBound) && (radian <= [arrayOfSectors objectAtIndex: i].higherBound))
        {
            newVal = circleRotationInRadian - [arrayOfSectors objectAtIndex:i].mid;
            return [arrayOfSectors objectAtIndex: i].tag;
        }
    }
    return 3;
}

- (IBAction)spinAction:(UIButton *)sender {
    if ((!spinning) && (lanQuay > 0))
    {
        spinTime = 0.006;
        [timer invalidate];
        [self buildUpRotation];
        spinning = true;
    }
    else if (spinning)
    {
        spinTime = 0.0001;
        [timer invalidate];
        [self turnOffRotation];
//        [self getSpinResult];
        spinning = false;
    }
}


@end
