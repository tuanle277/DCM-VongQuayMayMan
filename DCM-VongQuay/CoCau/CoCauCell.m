#import "CoCauCell.h"
#import "GiaiThuongModel.h"

@interface CoCauCell ()
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation CoCauCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void) setUp: (GiaiThuong *) phanThuong withIndexPath: (NSIndexPath *) indexPath
{
    self.giaiLabel.text = phanThuong.coCau;
    self.phanThuongLabel.text = phanThuong.phanThuong;
    self.soLuongLabel.text = [NSString stringWithFormat: @"%d", phanThuong.soLuong];
    self.indexPath = indexPath;
    self.giaiContainer.layer.borderWidth = 1.0;
    self.phanThuongContainer.layer.borderWidth = 1.0;
    self.soLuongContainer.layer.borderWidth = 1.0;
}

@end
