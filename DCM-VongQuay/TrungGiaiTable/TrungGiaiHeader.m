#import "TrungGiaiHeader.h"

@implementation TrungGiaiHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    [NSBundle.mainBundle loadNibNamed: @"TrungGiaiHeader" owner:self options:nil];
    [self addSubview: self.headerView];
    self.headerView.frame = self.bounds;
    self.headerView.layer.borderWidth = 1.0;
    self.nguoiChoiLabel.adjustsFontSizeToFitWidth = TRUE;
    self.phanThuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.SDTLabel.adjustsFontSizeToFitWidth = TRUE;
    self.thoiGianLabel.adjustsFontSizeToFitWidth = TRUE;
    return self;
}
@end
