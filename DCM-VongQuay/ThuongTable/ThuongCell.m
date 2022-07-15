#import "ThuongCell.h"

@interface ThuongCell()
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation ThuongCell

- (void) setUp:(GiaiThuong *)giaiThuong withIndexPath:(NSIndexPath *)indexPath
{
    self.phanThuongLabel.text = giaiThuong.phanThuong;
    self.thoigianLabel.text = giaiThuong.thoiGianTrungThuong;
    self.thoigianLabel.adjustsFontSizeToFitWidth = TRUE;
    self.phanThuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.phanThuongBackground.layer.borderWidth = 1.0;
    self.thoiGianBackground.layer.borderWidth = 1.0;
    self.indexPath = indexPath;
    [[self.phanThuongBackground.heightAnchor constraintEqualToAnchor: self.heightAnchor] setActive: TRUE];
    [[self.thoiGianBackground.heightAnchor constraintEqualToAnchor: self.heightAnchor] setActive: TRUE];
    [[self.phanThuongBackground.widthAnchor constraintEqualToAnchor: self.widthAnchor multiplier: 0.55] setActive: TRUE];
    [[self.thoiGianBackground.widthAnchor constraintEqualToAnchor: self.widthAnchor multiplier:0.45] setActive: TRUE];
    [[self.phanThuongBackground.leftAnchor constraintEqualToAnchor: self.leftAnchor] setActive: TRUE];
    [[self.thoiGianBackground.leftAnchor constraintEqualToAnchor: self.phanThuongBackground.rightAnchor] setActive: TRUE];
}

+ (NSString *) identifier
{
    return @"ThuongCell";
}

@end
