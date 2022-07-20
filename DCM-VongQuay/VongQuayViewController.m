#import "VongQuayViewController.h"
#import "GiaiThuongModel.h"
#import "NguoiChoiTrungGiaiModel.h"
#import "TrungGiaiView.h"
#import "ThuongView.h"
#import "VongQuayView.h"

@interface VongQuayViewController ()

@end

@implementation VongQuayViewController
{
    NSMutableArray<GiaiThuong *> *giaiThuongChungData;
    NSMutableArray<NguoiChoiTrungGiai *> *nguoiChoiTrungGiaiData;
    NSMutableArray<GiaiThuong *> *giaiThuongToiData;
}

/*
 Function để định giá trị ban đầu của biến
 */
- (void) configureDummyData
{
    // danh sách giải thưởng mẫu
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"phanthuong" ofType: @"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile: filePath];
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingAllowFragments error:&error];
    giaiThuongChungData = [NSMutableArray array];
    for (int i = 0; i < [jsonDict[@"phan_thuong"] count]; ++i)
    {
        [giaiThuongChungData addObject: [[GiaiThuong alloc] initWithInfo: jsonDict[@"phan_thuong"][i][@"co_cau"] withPhanThuong:jsonDict[@"phan_thuong"][i][@"phan_thuong"] andSoLuong: [jsonDict[@"phan_thuong"][i][@"so_luong"] intValue]]];
    }
    
    // danh sách người chơi trúng giải mẫu
    NSString *filePathPlayer = [[NSBundle mainBundle] pathForResource: @"nguoichoi" ofType: @"json"];
    NSData *jsonDataPlayer = [NSData dataWithContentsOfFile: filePathPlayer];
    NSDictionary *jsonDictPlayer = [NSJSONSerialization JSONObjectWithData: jsonDataPlayer options: NSJSONReadingAllowFragments error:&error];
    nguoiChoiTrungGiaiData = [NSMutableArray array];
    for (int i = 0; i < [jsonDictPlayer[@"nguoi_choi"] count]; ++i)
    {
        [nguoiChoiTrungGiaiData addObject: [[NguoiChoiTrungGiai alloc] initWithGiaiThuong:[[GiaiThuong alloc] initWithInfo: jsonDict[@"phan_thuong"][i][@"co_cau"] withPhanThuong: jsonDict[@"phan_thuong"][i][@"phan_thuong"] withThoiGian: jsonDictPlayer[@"nguoi_choi"][i][@"thoi_gian"]] withTen: jsonDictPlayer[@"nguoi_choi"][i][@"ten"] andSDT: jsonDictPlayer[@"nguoi_choi"][i][@"SDT"]]];

    }

    // danh sách giải thưởng đã trúng mẫu
    giaiThuongToiData = [NSMutableArray arrayWithObjects: [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 20.000đ" withThoiGian:@"22/06/2022"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 50.000đ" withThoiGian:@"24/06/2022"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 100.000đ" withThoiGian:@"12/04/2012"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 200.000đ" withThoiGian:@"15/04/2016"], [[GiaiThuong alloc] initWithPhanThuong:@"Thẻ nạp 100.000đ" withThoiGian:@"10/02/2021"], nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDummyData];
    self.vongQuayView.contentView.frame = self.view.frame;
    self.vongQuayView.giaiThuongChungData = giaiThuongChungData;
    self.vongQuayView.giaiThuongToiData = giaiThuongToiData;
    self.vongQuayView.nguoiChoiTrungGiaiData = nguoiChoiTrungGiaiData;
}
@end
