#import "CoCauCell.h"
#import "GiaiThuongModel.h"

@interface CoCauCell ()
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation CoCauCell

- (void) setUp: (GiaiThuong *) phanThuong withIndexPath: (NSIndexPath *) indexPath
{
    self.giaiLabel.text = phanThuong.coCau;
    self.phanThuongLabel.text = phanThuong.phanThuong;
    self.soLuongLabel.text = [NSString stringWithFormat: @"%d", phanThuong.soLuong];
    self.giaiLabel.adjustsFontSizeToFitWidth = TRUE;
    self.phanThuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.soLuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.indexPath = indexPath;
    self.giaiContainer.layer.borderWidth = 1.0;
    self.phanThuongContainer.layer.borderWidth = 1.0;
    self.soLuongContainer.layer.borderWidth = 1.0;
    [[self.giaiContainer.heightAnchor constraintEqualToAnchor: self.heightAnchor] setActive:TRUE];
    [[self.phanThuongContainer.heightAnchor constraintEqualToAnchor: self.heightAnchor] setActive: TRUE];
    [[self.soLuongContainer.heightAnchor constraintEqualToAnchor: self.heightAnchor] setActive: TRUE];
    [[self.giaiContainer.widthAnchor constraintEqualToAnchor: self.widthAnchor multiplier: 0.25] setActive: TRUE];
    [[self.phanThuongContainer.widthAnchor constraintEqualToAnchor: self.widthAnchor multiplier: 0.5] setActive: TRUE];
    [[self.soLuongContainer.widthAnchor constraintEqualToAnchor: self.widthAnchor multiplier: 0.25] setActive: TRUE];
    [[self.giaiContainer.leftAnchor constraintEqualToAnchor: self.leftAnchor] setActive: TRUE];
    [[self.phanThuongContainer.leftAnchor constraintEqualToAnchor: self.giaiContainer.rightAnchor] setActive: TRUE];
    [[self.soLuongContainer.leftAnchor constraintEqualToAnchor: self.phanThuongContainer.rightAnchor] setActive: TRUE];
}

+ (NSString *) identifier
{
    return @"CoCauCell";
}

@end
