#import "ViewController.h"
#import "PhanVongQuay.h"
#import "VePhanVongQuay.h"
#import "Segment.h"
#import "VongQuay.h"
#import "Utility.h"
#import "GiaiThuongModel.h"
#import "CoCauView.h"
#include <stdlib.h>
#import "NguoiChoiTrungGiaiModel.h"
#import "TrungGiaiView.h"
#import "ThuongView.h"


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
    NSMutableArray<GiaiThuong *> *giaiThuongChungData;
    NSMutableArray<NguoiChoiTrungGiai *> *nguoiChoiTrungGiaiData;
    NSMutableArray<GiaiThuong *> *giaiThuongToiData;
    CGFloat sectorLength;
    UIAlertController *prizeAlert;
    UIAlertController *voucherDecisionAlert;
    UIAlertController *voucherAlert;
    UIAlertController *coCauAlert;
    NSString *voucher;
    NSMutableArray *colors;
    int numberOfSectors;
    int count;
    BOOL spinning;
    float diameter;
    float radius;
    float spinTime;
    int spinTimeInSecond;
    int lanQuay;
    int rewardIndex;
}

@synthesize sectorLabel = _sectorLabel;
@synthesize screenWidth = _screenWidth;
@synthesize screenHeight = _screenHeight;

#define PI 3.14

/*
 Function để định giá trị ban đầu của biến
 */
- (void) configureVariables
{
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    lanQuay = 0;
    diameter = screenWidth * 9/10;
    radius = diameter / 2;
    numberOfSectors = 8;
    spinTimeInSecond = 5;
    sectorLength = PI * 2 / numberOfSectors;
    arrayOfSectors = [[NSMutableArray alloc]init];
    
    // danh sách giải thưởng
    rewards = [NSMutableArray arrayWithObjects:@"Thẻ nạp 1", @"Thẻ nạp 2", @"Thẻ nạp 3", @"Thẻ nạp 4", @"Thẻ nạp 5", @"Thẻ nạp 6", @"Thẻ nạp 7", @"Thẻ nạp 8", nil];

    // danh sách màu từng phần vòng quay
    colors = [NSMutableArray arrayWithObjects: UIColor.blackColor, UIColor.blueColor, UIColor.yellowColor, UIColor.whiteColor, UIColor.greenColor, UIColor.grayColor, UIColor.orangeColor, UIColor.whiteColor, nil];
    
    // danh sách giải thưởng mẫu
    giaiThuongChungData = [NSMutableArray arrayWithObjects: [[GiaiThuong alloc] initWithInfo: @"Giải nhất" withPhanThuong: @"Thẻ nạp 100.000đ" andSoLuong: 100], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], [[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" andSoLuong: 50], nil];
    
    // danh sách người chơi trúng giải mẫu
    nguoiChoiTrungGiaiData = [NSMutableArray arrayWithObjects: [[NguoiChoiTrungGiai alloc] initWithGiaiThuong:[[GiaiThuong alloc] initWithInfo: @"Giải nhất" withPhanThuong: @"Thẻ nạp 100.000đ" withThoiGian: @"22/06/2022"] withTen: @"Nguyễn Văn A" andSDT:@"0932482122"], [[NguoiChoiTrungGiai alloc] initWithGiaiThuong:[[GiaiThuong alloc] initWithInfo: @"Giải nhì" withPhanThuong: @"Thẻ nạp 50.000đ" withThoiGian: @"23/06/2022"] withTen: @"Nguyễn Văn B" andSDT:@"0923828382"], nil];
    
    // danh sách phần thưởng của tôi mẫu
    giaiThuongToiData = [NSMutableArray arrayWithObjects: [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 20.000đ" withThoiGian:@"22/06/2022"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 50.000đ" withThoiGian:@"24/06/2022"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 100.000đ" withThoiGian:@"12/04/2012"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 200.000đ" withThoiGian:@"15/04/2016"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 100.000đ" withThoiGian:@"10/02/2021"], nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVariables];
    [self configureSpinButton];
    [self configureTitles];
    [self configureButtons];
    [self buildCircle];
    NSLog(@"_____________________________________________________ \r %f %f %f", self.buttonsContainer.frame.size.width, self.view.frame.size.width, self.titleBackGroundView.frame.size.width);
    NSLog(@"_____________________________________________________ \r %f %f %f", self.buttonsContainer.frame.size.height, self.view.frame.size.height, self.titleBackGroundView.frame.size.height);
//    VongQuay *vongQuay = [[VongQuay alloc] initWithFrame: self.view.bounds  withSections: numberOfSectors withDiameter: diameter];
//
//    [vongQuay buildCircle];
//    [self.view addSubview: vongQuay.circle];
//    [self.view addSubview: vongQuay.indicator];

}

- (void) configureSpinButton
{
    NSLog(@"%f %f", self.spinBtn.frame.size.width, self.spinBtn.frame.size.height);
    [self.spinBtn.layer setCornerRadius: self.view.frame.size.height / 28];
    [self.spinBtn setClipsToBounds: TRUE];
    [self.spinBtn.layer setBorderWidth: 5.0];
    [self.spinBtn.layer setBorderColor: UIColor.yellowColor.CGColor];
    [self.spinBtn.titleLabel adjustsFontSizeToFitWidth];
    [[self.spinBtn.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: screenHeight * 9 /10] setActive:TRUE];

}

#pragma mark autolayout

- (void) configureTitles
{
    // top anchor
    [[self.introTitle.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: screenHeight / 18] setActive: TRUE];
    [[self.titleBackGroundView.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: screenHeight / 8] setActive: TRUE];
}

- (void) configureButtons
{
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
    self.lanQuayLbl.textAlignment = NSTextAlignmentRight;
    
  // top anchor
    [[self.buttonsContainer.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:screenHeight / 5] setActive: TRUE];
    [[self.coCauLabel.topAnchor constraintEqualToAnchor: self.coCaubtn.bottomAnchor constant: 1] setActive: TRUE];
    [[self.trungGiaiLabel.topAnchor constraintEqualToAnchor: self.trungGiaiBtn.bottomAnchor constant: 1] setActive: TRUE];
    [[self.thuongLabel.topAnchor constraintEqualToAnchor: self.thuongBtn.bottomAnchor constant: 1] setActive: TRUE];
    [[self.lanQuayLbl.topAnchor constraintEqualToAnchor: self.lanQuayContainer.bottomAnchor constant: 1] setActive: TRUE];
//    [[self.lanQuayBtn.topAnchor constraintEqualToAnchor: self.lanQuayContainer.topAnchor constant: (self.lanQuayContainer.frame.size.height - self.lanQuayBtn.frame.size.height) / 2] setActive: TRUE];

    // left anchor
    [[self.coCaubtn.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: self.view.frame.size.width / 10] setActive:TRUE];
    [[self.trungGiaiBtn.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: self.view.frame.size.width * 3 / 10] setActive:TRUE];
    [[self.thuongBtn.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: self.view.frame.size.width / 2] setActive:TRUE];
    [[self.lanQuayContainer.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: self.view.frame.size.width * 7 / 10] setActive:TRUE];
    [[self.lanQuayBtn.leftAnchor constraintEqualToAnchor: self.lanQuayContainer.rightAnchor constant: -8] setActive: TRUE];

    // right anchor
    [[self.lanQuayLabel.rightAnchor constraintEqualToAnchor: self.lanQuayContainer.rightAnchor constant: -3] setActive: TRUE];
    
    self.lanQuayContainer.layer.borderWidth = 1.0;
    

}

#pragma mark ConfigureButtons

/*
 Functions của các button hiện bảng thông tin (cơ cấu giải thưởng, danh sách ngừời chơi trúng giải, danh sách giải người dùng đã trúng), và hiện alert để người chơi nhập vouchẻ
 - Mỗi bảng thông tin là object kế thừa UIView chứa 1 header kế thừa UIView và 1 UITableView, dùng animation của UIView để hiện bảng
 - Mỗi bảng được định nghĩa bằng các file trong các folder tên (tên bảng) + "Table"
 */

- (IBAction)thuongAction:(UIButton *)sender
{
    ThuongView *thuongView = [[ThuongView alloc] initWithFrame: CGRectMake(screenWidth / 16, screenHeight * 5 / 16 , screenWidth * 7 / 8, screenHeight * 3 / 8) withData: giaiThuongToiData];
    [thuongView show];
}

- (IBAction)trungGiaiAction:(UIButton *)sender
{
    TrungGiaiView *trungGiaiView = [[TrungGiaiView alloc] initWithFrame:CGRectMake(screenWidth / 16, screenHeight * 5 / 16 , screenWidth * 7/8, screenHeight * 3 / 8) withData:nguoiChoiTrungGiaiData];
    [trungGiaiView show];
}

- (IBAction)coCauAction:(UIButton *)sender
{
    CoCauView *coCauView = [[CoCauView alloc] initWithFrame: CGRectMake(screenWidth / 16, screenHeight * 5 / 16 , screenWidth * 7 / 8, screenHeight * 3 / 8) withData: giaiThuongChungData];
    [coCauView show];
}

- (IBAction)tangLuotQuayAction:(UIButton *)sender
{
    [self configureVoucherAlert];
    [self presentViewController: voucherAlert animated:YES completion:nil];
}

#pragma mark ConfigureLuckyWheel
// Building the wheel (needs partitioning)**

/*
 Functions dùng để build UI vòng quay:
 - buildCircle: build background hình tròn kế thừa UIView, cùng lúc chia hình tròn thành từng quạt bằng nhau với các màu theo thứ tự trong biến mảng local "colors".
 - buildItems: build các thành phần giải thưởng trên từng quạt (hiện tại là UILabel với text theo thứ tự trong biến mảng local "rewards", các giải thưởng này dynamic, chỉ việc tạo class object mong muốn rồi lấy text trả về sau khi quay và tên người chơi để tạo object đó.
 - buildSectors: build layer dưới mỗi quạt, là một NSObject để lưu khoảng góc quay (theo radian) của từng quạt, vị trí bắt đầu là 0 rad, mỗi khoảng được tính dựa trên số quạt (2 * PI / số quạt) -> object này dùng để tính góc để quay vào giải thưởng random cho trước. Giải thưởng sẽ được tính theo độ lệch của vòng quay so với vị trí ban đầu (theo rad), check coi độ lệch đó nằm trong khoảng của quạt nào và trả item quạt đó chứa.
 */
- (void) buildCircle
{
    // Tạo nền của vòng quay
    circle = [[UIView alloc] initWithFrame: CGRectMake((screenWidth - diameter) / 2, (screenHeight - diameter) * 7/10, radius * 2, radius * 2)];
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

    indicator = [[UIView alloc] initWithFrame:CGRectMake(10, (screenHeight - diameter) * 7 / 10 + radius, (self.view.frame.size.width - diameter) / 2 - 10, 2)];
    indicator.backgroundColor = UIColor.whiteColor;

    [self.view addSubview: circle];
    [circle addSubview: sectors];
    [self.view addSubview: indicator];

    [self buildItems];
    [self buildSectors];
}

- (void) buildItems
{
    // make items (UILabel) (items có thể thay đổi thành object nào tùy thích)
    for (int i = 0; i < numberOfSectors; i++) {
        UILabel *word = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, radius, 70)];
        word.text = rewards[i];
        word.adjustsFontSizeToFitWidth = TRUE;
        word.lineBreakMode = NSLineBreakByWordWrapping;
        word.numberOfLines = 0;
        word.font = [UIFont fontWithName: @"Times new roman" size: radius / 8];
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
        // arrayOfSectors chứa các object sector, tức layer dưới vòng quay chứa khoảng radian của mỗi vòng quay
        [arrayOfSectors addObject:sector];
    }
}

#pragma mark spinAction

/*
 Functions for spinning, accelerating, slowing down after a given duration (in seconds)
 cách hoạt động:
 - buildUpRotation: bắt đầu quay từ một tốc độ chậm và tăng dần
 - updateUp: tăng tới 1 tốc độ và không tăng nữa
 - turnOffRotation: chuyển tới một tốc độ thấp hơn theo tỉ lệ
 - upDateDown: giảm dần tốc độ cho đến khi dừng hẳn, cuối hàm lấy kết quả bằng số rad lệch đi từ gốc
*/
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
    count ++;

    // 0.06730 -> thời gian từ lúc chậm lại cho đến khi dừng hẳn (test 1 - 5s)
    // 4728 -> số vòng xoay được trong 1 giây => nhân số giây mong muốn
    if (count >= 4730 * spinTimeInSecond)
    {
        [self getSpinResult];
        if ((atan2f(circle.transform.b, circle.transform.a) + 0.06710 >= arrayOfSectors[rewardIndex].lowerBound - (PI * 2 / numberOfSectors)) && (atan2f(circle.transform.b, circle.transform.a) + 0.06710 <= arrayOfSectors[rewardIndex].higherBound - (PI * 2 / numberOfSectors)))
        {
            // tính tốc độ chậm lại thành của vòng quay
            spinTime = (-spinTime) / 1835;
            [timer invalidate];
            [self turnOffRotation];
        }
    }
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
    // Quay chậm cho đến lúc dừng hẳn
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
        // Vòng ngược lại hoặc tiến tới để dừng ở giữa phần vòng quay
        CGAffineTransform t = CGAffineTransformRotate(circle.transform, -newVal);
        circle.transform = t;
        circleRotationInRadian = atan2f(circle.transform.b, circle.transform.a);
        NSLog(@"phần thưởng là: %@, số giây xoay là: %d \r ______________________________________", rewards[[self getTag: circleRotationInRadian]], count / 4730);
        [self configureWinningAlert: [rewards objectAtIndex: [self getTag: circleRotationInRadian]]];
        [self presentViewController: prizeAlert animated:YES completion:nil];
        lanQuay -= 1;
        self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
    }
}

#pragma mark ketQua

/*
 - getSpinResult: để lấy kết qủa random được từ server
 - getTag: Lấy kết quả quay được, tính theo radian
 */
- (void) getSpinResult
{
    rewardIndex = (int) arc4random_uniform(rewards.count);
    NSLog(@"reward index is %d, phần thưởng là %@, with upper bound %f, and lower bound %f", rewardIndex, rewards[rewardIndex], arrayOfSectors[rewardIndex].higherBound, arrayOfSectors[rewardIndex].lowerBound);
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
    // note: wheel spins faster than real time 4730 times
    if (lanQuay > 0)
    {
        spinTime = 0.006;
        count = 0;
        [timer invalidate];
        [self getSpinResult];
        [self buildUpRotation];
    }

}

#pragma mark alertControllers

/*
 Functions để build AlertController để người chơi nhập mã lượt quay và thông báo trúng giải:
 - voucher: dùng biến local "lanQuay" để lưu trữ số lần quay hiện có, nếu nhập đúng voucher thì biến tăng thêm, chỉ quay khi biến > 0. UI cũng là định dạng của biến, xong khi quay thì biến -= 1 và redraw UI.
 */

- (void) configureWinningAlert: (NSString *) prize
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString: @"Chúc mừng"];
    [title addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: self.view.frame.size.width / 18] range: NSMakeRange(0, title.length)];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat: @"Bạn đã nhận được phần thưởng \r %@", prize]];
    [message addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: self.view.frame.size.width / 26] range: NSMakeRange(0, message.length)];
    prizeAlert =  [UIAlertController alertControllerWithTitle:@"" message: @""
                                               preferredStyle:UIAlertControllerStyleAlert];
    [prizeAlert setValue: title forKey: @"attributedTitle"];
    [prizeAlert setValue: message forKey: @"attributedMessage"];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem: prizeAlert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem: nil attribute:NSLayoutAttributeNotAnAttribute multiplier: 1 constant: self.view.frame.size.height / 5];
    [prizeAlert.view addConstraint: height];
    [prizeAlert.view.layer setCornerRadius: 50.0];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle: @"OK" style:UIAlertActionStyleDefault handler: nil];
    [prizeAlert addAction: actionOk];
}

- (void) configureVoucherAlert
{
    voucherAlert = [UIAlertController alertControllerWithTitle: @"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString: @"Voucher"];
    [title addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: self.view.frame.size.width / 20] range: NSMakeRange(0, 7)];
    [voucherAlert setValue: title forKey: @"attributedTitle"];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem: voucherAlert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem: nil attribute:NSLayoutAttributeNotAnAttribute multiplier: 1 constant: self.view.frame.size.height / 5];
    [voucherAlert.view addConstraint: height];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle: @"Cancel" style:UIAlertActionStyleCancel handler: nil];
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
    
    [voucherAlert addAction: actionCancel];
    [voucherAlert addAction: actionDongY];
}

// nhập "voucher" để quay
- (void) configureVoucherDecision
{
    NSMutableAttributedString *voucherDecision;
    if ([voucher isEqualToString: @"voucher"])
    {
        voucherDecision = [[NSMutableAttributedString alloc] initWithString: @"Chúc mừng bạn đã nhận được một lượt chơi"];
        [voucherDecision addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: self.view.frame.size.width / 20] range: NSMakeRange(0, voucherDecision.length)];
        lanQuay += 1;
        self.lanQuayLabel.text = [NSString stringWithFormat: @"%d", lanQuay];
        
    }
    else
    {
        voucherDecision = [[NSMutableAttributedString alloc] initWithString: @"Mã voucher không hợp lệ"];
        [voucherDecision addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: self.view.frame.size.width / 20] range: NSMakeRange(0, 0)];
    }
    
    voucherDecisionAlert = [UIAlertController alertControllerWithTitle:@"" message: @"" preferredStyle:UIAlertControllerStyleAlert];
    [voucherDecisionAlert setValue: voucherDecision forKey: @"attributedTitle"];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem: voucherDecisionAlert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem: nil attribute:NSLayoutAttributeNotAnAttribute multiplier: 1 constant: self.view.frame.size.height / 6];
    [voucherDecisionAlert.view addConstraint: height];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler:nil];
    
    [voucherDecisionAlert addAction: cancelBtn];
}


@end
