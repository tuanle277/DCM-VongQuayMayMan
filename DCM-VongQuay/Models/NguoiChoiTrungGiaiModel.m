#import "NguoiChoiTrungGiaiModel.h"

@implementation NguoiChoiTrungGiai

- (id) initWithGiaiThuong:(GiaiThuong *)giaiThuong withTen:(NSString *)ten andSDT:(NSString *)SDT
{
    self = [super init];
    if (self)
    {
        self.phanThuong = giaiThuong;
        self.tenNguoiChoi = ten;
        self.soDienThoai = SDT;
    }
    return self;
}

@end
