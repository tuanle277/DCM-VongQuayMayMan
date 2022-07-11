#import "TrungGiaiCell.h"

@interface TrungGiaiCell()
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation TrungGiaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setUp:(NguoiChoiTrungGiai *)nguoiChoi withIndexPath:(NSIndexPath *)indexPath
{
    self.nguoiChoiLabel.text = nguoiChoi.tenNguoiChoi;
    self.phanThuongLabel.text = nguoiChoi.phanThuong.phanThuong;
    self.SDTLabel.text = nguoiChoi.soDienThoai;
    self.thoiGianLabel.text = nguoiChoi.phanThuong.thoiGianTrungThuong;
    self.nguoiChoiLabel.adjustsFontSizeToFitWidth = TRUE;
    self.phanThuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.SDTLabel.adjustsFontSizeToFitWidth = TRUE;
    self.thoiGianLabel.adjustsFontSizeToFitWidth = TRUE;
    self.nguoiChoiBackground.layer.borderWidth = 1.0;
    self.phanThuongBackground.layer.borderWidth = 1.0;
    self.SDTBackground.layer.borderWidth = 1.0;
    self.thoiGianBackground.layer.borderWidth = 1.0;
    self.indexPath = indexPath;
}

@end
