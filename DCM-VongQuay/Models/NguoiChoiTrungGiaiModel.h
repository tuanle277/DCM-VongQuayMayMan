#import <Foundation/Foundation.h>
#import "GiaiThuongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NguoiChoiTrungGiai : NSObject

@property NSString *tenNguoiChoi;
@property NSString *soDienThoai;
@property GiaiThuong *phanThuong;

- (id) initWithGiaiThuong: (GiaiThuong *) giaiThuong withTen: (NSString *) ten andSDT: (NSString *) SDT;

@end

NS_ASSUME_NONNULL_END
