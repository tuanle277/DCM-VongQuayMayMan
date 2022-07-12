#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiaiThuong : NSObject

@property NSString *coCau;
@property NSString *phanThuong;
@property NSString *thoiGianTrungThuong;
@property int soLuong;

- (id) initWithInfo: (NSString *) newCoCau withPhanThuong: (NSString *) newPhanThuong andSoLuong: (int) soLuong;

- (id) initWithInfo: (NSString *) newCoCau withPhanThuong: (NSString *) newPhanThuong withThoiGian: (NSString *) newTime;

- (id) initWithPhanThuong: (NSString *) newPhanThuong withThoiGian: (NSString *) newTime;

@end

NS_ASSUME_NONNULL_END
