#import "ViewController.h"
#import "PhanVongQuay.h"
#import "VePhanVongQuay.h"
#import "Segment.h"
#import "VongQuay.h"
#import "Utility.h"
#import "GiaiThuongModel.h"
#import "CoCauView.h"


@interface VongQuayViewController ()

@end

@implementation VongQuayViewController
{
    UIView *circle;
    UIView *indicator;
    CGFloat circleRotationInRadian;
    CGFloat screenWidth;
    CGFloat screenHeight;
    VongQuay *vongQuay;
    NSTimer *timer;
    UILabel *im;
    NSMutableArray<PhanVongQuay *> *arrayOfSectors;
    NSMutableArray<NSString *> *rewards;
    NSMutableArray<GiaiThuong *> *giaiThuongData;
    CGFloat sectorLength;
    UIAlertController *prizeAlert;
    UIAlertController *voucherDecisionAlert;
    UIAlertController *voucherAlert;
    UIAlertController *coCauAlert;
    NSString *voucher;
    NSMutableArray *colors;
    int numberOfSectors;
    BOOL spinning;
    int diameter;
    int radius;
    float spinTime;
    int lanQuay;
}

@synthesize sectorLabel = _sectorLabel;
@synthesize screenWidth = _screenWidth;
@synthesize screenHeight = _screenHeight;

#define PI 3.14


- (void) configureVariables
{
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    lanQuay = 0;
    diameter = screenWidth * 8/9;
    radius = diameter / 2;
    numberOfSectors = 8;
    sectorLength = PI * 2 / numberOfSectors;
    arrayOfSectors = [[NSMutableArray alloc]init];
    
    // danh sách giải thưởng
    rewards = [NSMutableArray arrayWithObjects:@"Thẻ nạp 1", @"Thẻ nạp 2", @"Thẻ nạp 3", @"Thẻ nạp 4", @"Thẻ nạp 5", @"Thẻ nạp 6", @"Thẻ nạp 200.000k", @"Thẻ nạp 8", nil];
    
    // danh sách màu từng phần vòng quay
    colors = [NSMutableArray arrayWithObjects: UIColor.blackColor, UIColor.blueColor, UIColor.yellowColor, UIColor.whiteColor, UIColor.greenColor, UIColor.grayColor, UIColor.orangeColor, UIColor.whiteColor, nil];
    
    // danh sách giải thưởng mẫu
    giaiThuongData = [NSMutableArray arrayWithObjects: [[GiaiThuong alloc] initWithInfo: @"Giải nhất" withPhanThuong: @"Thẻ nạp 100.000đ" andSoLuong: 100], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setAutoresizesSubviews: TRUE];
    [self configureVariables];
    [self configureSpinButton];
    [self configureTitles];
    [self configureButtons];
    [self buildCircle];
    NSLog(@"Screen's width is %f, screen's height is %f", screenWidth, screenHeight);
    
    
//    vongQuay = [[VongQuay alloc] initWithFrame:self.view.frame
//                                 withSections:numberOfSectors withDiameter:diameter];
//    vongQuay.colors = colors;
//    vongQuay.rewards = rewards;
//    [vongQuay buildCircle];
//    arrayOfSectors = vongQuay.arrayOfSectors;
//    [self.view addSubview: vongQuay.circle];
//    [self.view addSubview: vongQuay.indicator];
}

- (void) configureSpinButton
{
    [self.spinBtn.layer setCornerRadius: 30.0];
    [self.spinBtn setClipsToBounds: TRUE];
    [self.spinBtn.layer setBorderWidth: 5.0];
    [self.spinBtn.layer setBorderColor: UIColor.yellowColor.CGColor];
    [self.spinBtn setTranslatesAutoresizingMaskIntoConstraints: NO];
    [[self.spinBtn.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: screenHeight * 9 /10] setActive:TRUE];
    [[self.spinBtn.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant: (screenWidth - self.spinBtn.frame.size.width) / 2]setActive:TRUE];
    [[self.spinBtn.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant: -(screenHeight / 10 - self.spinBtn.frame.size.height)] setActive: TRUE];
    [[self.spinBtn.rightAnchor constraintEqualToAnchor: self.view.rightAnchor constant: -(screenWidth - self.spinBtn.frame.size.width) / 2] setActive: TRUE];
}

#pragma mark autolayout

- (void) configureTitles
{
    [self.titleView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.introTitle setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.titleBackGroundView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    // width anchor
    
    [[self.introTitle.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: screenHeight / 18] setActive: TRUE];
    [[self.introTitle.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: (screenWidth - self.introTitle.frame.size.width) / 2] setActive: TRUE];
    [[self.introTitle.rightAnchor constraintEqualToAnchor: self.view.rightAnchor constant: -(screenWidth - self.introTitle.frame.size.width) / 2] setActive: TRUE];
    
    [[self.titleBackGroundView.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: screenHeight / 8] setActive: TRUE];
    [[self.titleBackGroundView.leftAnchor constraintEqualToAnchor: self.view.leftAnchor] setActive: TRUE];
    [[self.titleBackGroundView.rightAnchor constraintEqualToAnchor: self.view.rightAnchor] setActive: TRUE];
//    [[self.titleBackGroundView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant: 0 ] setActive: TRUE];
    
    [[self.titleView.topAnchor constraintEqualToAnchor: self.titleBackGroundView.topAnchor constant: (self.titleBackGroundView.frame.size.height - self.titleView.frame.size.height) / 2] setActive:TRUE];
    [[self.titleView.leftAnchor constraintEqualToAnchor: self.titleBackGroundView.leftAnchor constant: (self.titleBackGroundView.frame.size.width - self.titleView.frame.size.width) / 2] setActive: TRUE];
    [[self.titleView.rightAnchor constraintEqualToAnchor: self.titleBackGroundView.rightAnchor constant: -(self.titleBackGroundView.frame.size.width - self.titleView.frame.size.width) / 2] setActive: TRUE];
    [[self.titleView.bottomAnchor constraintEqualToAnchor: self.titleBackGroundView.bottomAnchor constant: -(self.titleBackGroundView.frame.size.height - self.titleView.frame.size.height) / 2] setActive:TRUE];
}

- (void) configureButtons
{
//    [self.buttonsContainer setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.coCaubtn setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.thuongBtn setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.trungGiaiBtn setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.coCauLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.trungGiaiLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.thuongLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.lanQuayLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.lanQuayBtn setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.lanQuayLbl setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.lanQuayContainer setTranslatesAutoresizingMaskIntoConstraints: NO];

    [self.lanQuayLabel setAdjustsFontSizeToFitWidth: TRUE];
    [self.introTitle setAdjustsFontSizeToFitWidth: TRUE];
    [self.titleView setAdjustsFontSizeToFitWidth: TRUE];
    [self.coCauLabel setAdjustsFontSizeToFitWidth: TRUE];
    [self.thuongLabel setAdjustsFontSizeToFitWidth: TRUE];
    [self.trungGiaiLabel setAdjustsFontSizeToFitWidth: TRUE];
    [self.lanQuayLbl setAdjustsFontSizeToFitWidth: TRUE];
    self.coCauLabel.textAlignment = NSTextAlignmentCenter;
    self.trungGiaiLabel.textAlignment = NSTextAlignmentCenter;
    self.thuongLabel.textAlignment = NSTextAlignmentCenter;
    self.introTitle.textAlignment = NSTextAlignmentCenter;
    self.lanQuayLabel.textAlignment = NSTextAlignmentCenter;
    self.titleView.textAlignment = NSTextAlignmentCenter;
//
////    [[self.lanQuayBtn.widthAnchor constraintEqualToAnchor: self.buttonsContainer.heightAnchor multiplier: 1 / 2] setActive: TRUE];
//
//    // top anchor -> 11
//    [[self.buttonsContainer.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:screenHeight / 5] setActive: TRUE];
//    [[self.coCaubtn.topAnchor constraintEqualToAnchor: self.buttonsContainer.topAnchor constant: (self.buttonsContainer.frame.size.height - self.coCaubtn.frame.size.height) / 2] setActive: TRUE];
//    [[self.trungGiaiBtn.topAnchor constraintEqualToAnchor: self.buttonsContainer.topAnchor constant: (self.buttonsContainer.frame.size.height - self.trungGiaiBtn.frame.size.height) / 2] setActive: TRUE];
//    [[self.thuongBtn.topAnchor constraintEqualToAnchor: self.buttonsContainer.topAnchor constant: (self.buttonsContainer.frame.size.height - self.thuongBtn.frame.size.height) / 2] setActive: TRUE];
//    [[self.lanQuayContainer.topAnchor constraintEqualToAnchor: self.buttonsContainer.topAnchor constant: (self.buttonsContainer.frame.size.height - self.lanQuayContainer.frame.size.height) / 2] setActive: TRUE];
//    [[self.coCauLabel.topAnchor constraintEqualToAnchor: self.coCaubtn.bottomAnchor constant: 1] setActive: TRUE];
//    [[self.trungGiaiLabel.topAnchor constraintEqualToAnchor: self.trungGiaiBtn.bottomAnchor constant: 1] setActive: TRUE];
//    [[self.thuongLabel.topAnchor constraintEqualToAnchor: self.thuongBtn.bottomAnchor constant: 1] setActive: TRUE];
//    [[self.lanQuayLbl.topAnchor constraintEqualToAnchor: self.lanQuayContainer.bottomAnchor constant: 1] setActive: TRUE];
//    [[self.lanQuayBtn.topAnchor constraintEqualToAnchor: self.lanQuayContainer.topAnchor constant: (self.lanQuayContainer.frame.size.height - self.lanQuayBtn.frame.size.height) / 2] setActive: TRUE];
//    [[self.lanQuayLabel.topAnchor constraintEqualToAnchor: self.lanQuayContainer.topAnchor constant: (self.lanQuayContainer.frame.size.height - self.lanQuayLabel.frame.size.height) / 2] setActive: TRUE];
//
////    //left anchor -> 10 (tru lanQuayLabel)
//    [[self.buttonsContainer.leftAnchor constraintEqualToAnchor: self.view.leftAnchor] setActive: TRUE];
//    [[self.coCaubtn.leftAnchor constraintEqualToAnchor: self.buttonsContainer.leftAnchor constant: self.buttonsContainer.frame.size.width / 10] setActive:TRUE];
//    [[self.trungGiaiBtn.leftAnchor constraintEqualToAnchor: self.buttonsContainer.leftAnchor constant: self.buttonsContainer.frame.size.width * 3 / 10] setActive:TRUE];
//    [[self.thuongBtn.leftAnchor constraintEqualToAnchor: self.buttonsContainer.leftAnchor constant: self.buttonsContainer.frame.size.width / 2] setActive:TRUE];
//    [[self.lanQuayContainer.leftAnchor constraintEqualToAnchor: self.buttonsContainer.leftAnchor constant: self.buttonsContainer.frame.size.width * 7 / 10] setActive:TRUE];
//    [[self.coCauLabel.leftAnchor constraintEqualToAnchor: self.coCaubtn.leftAnchor constant: (self.coCaubtn.frame.size.width - self.coCauLabel.frame.size.width) / 2] setActive: TRUE];
//    [[self.trungGiaiLabel.leftAnchor constraintEqualToAnchor: self.trungGiaiBtn.leftAnchor constant: (self.trungGiaiBtn.frame.size.width - self.trungGiaiLabel.frame.size.width) / 2] setActive: TRUE];
//    [[self.thuongLabel.leftAnchor constraintEqualToAnchor: self.thuongBtn.leftAnchor constant: (self.thuongBtn.frame.size.width - self.thuongLabel.frame.size.width) / 2] setActive: TRUE];
//    [[self.lanQuayLbl.leftAnchor constraintEqualToAnchor: self.lanQuayContainer.leftAnchor constant: (self.lanQuayContainer.frame.size.width - self.lanQuayLbl.frame.size.width) / 2] setActive: TRUE];
//    [[self.lanQuayBtn.leftAnchor constraintEqualToAnchor: self.lanQuayContainer.rightAnchor constant: -2] setActive: TRUE];
//
////    // right anchor
//    [[self.lanQuayLabel.rightAnchor constraintEqualToAnchor: self.lanQuayContainer.rightAnchor constant: -3] setActive: TRUE];
//    [[self.buttonsContainer.rightAnchor constraintEqualToAnchor: self.view.rightAnchor] setActive: TRUE];
//    [[self.coCaubtn.rightAnchor constraintEqualToAnchor: self.lanQuayContainer.rightAnchor constant: -self.buttonsContainer.frame.size.width * 4/5] setActive: TRUE];
//    NSLog(@"%f %f", self.titleBackGroundView.frame.size.width, self.view.frame.size.width);
//    NSLog(@"%f %f %f %f", self.coCaubtn.frame.size.width, self.coCaubtn.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
////
////
////    //bottom anchor
//    [[self.buttonsContainer.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant: - screenHeight * 9/13 ] setActive: TRUE];
//

    
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
    CoCauView *view = [[CoCauView alloc] initWithFrame: CGRectMake(screenWidth / 16, screenHeight * 5 / 16 , screenWidth * 7 / 8, screenHeight * 3 / 8) withData: giaiThuongData];
    [view show];
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
    circle = [[UIView alloc] initWithFrame: CGRectMake((screenWidth - diameter) / 2, screenHeight * 2/5, radius * 2, radius * 2)];
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

    indicator = [[UIView alloc] initWithFrame:CGRectMake(10, screenHeight * 2 / 5 + radius, (self.view.frame.size.width - diameter) / 2 - 10, 1)];
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
        word.adjustsFontSizeToFitWidth = TRUE;
        word.numberOfLines = 2;
        word.font = [UIFont fontWithName: @"Times new roman" size:26];
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

#pragma mark alerts

- (void) buildCoCauAlert
{
    coCauAlert = [UIAlertController alertControllerWithTitle: @"Giải thưởng" message:@"" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"Cancel" style:UIAlertActionStyleCancel handler: nil];
    
    [coCauAlert addAction: cancelAction];

    
//    tableView.delegate = self;
//    tableView.dataSource = self;
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

// nhập "voucher" để quay
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


@end
