#import "ThuongCell.h"

@interface ThuongCell()
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation ThuongCell

- (void) setUp:(GiaiThuong *)giaiThuong withIndexPath:(NSIndexPath *)indexPath
{
    self.phanThuongLabel.text = giaiThuong.phanThuong;
    self.thoigianLabel.text = giaiThuong.thoiGianTrungThuong;
    self.phanThuongBackground.layer.borderWidth = 1.0;
    self.thoiGianBackground.layer.borderWidth = 1.0;
    self.indexPath = indexPath;
}

+ (NSString *) identifier
{
    return @"ThuongCell";
}

@end
