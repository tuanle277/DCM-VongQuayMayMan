#import "GiaiThuongModel.h"

@implementation GiaiThuong

- (id) initWithInfo:(NSString *)newCoCau withPhanThuong:(NSString *)newPhanThuong andSoLuong: (int) soLuong
{
    self = [super init];
    if (self)
    {
        self.coCau = newCoCau;
        self.phanThuong = newPhanThuong;
        self.soLuong = soLuong;
    }
    return self;
}

- (id) initWithInfo:(NSString *)newCoCau withPhanThuong:(NSString *)newPhanThuong withThoiGian:(NSString *)newTime
{
    self = [super init];
    if (self)
    {
        self.coCau = newCoCau;
        self.phanThuong = newPhanThuong;
        self.thoiGianTrungThuong = newTime;
    }
    return self;
}

- (id) initWithPhanThuong: (NSString *) newPhanThuong withThoiGian: (NSString *) newTime
{
    self = [super init];
    if (self)
    {
        self.phanThuong = newPhanThuong;
        self.thoiGianTrungThuong = newTime;
    }
    return self;
}

@end
