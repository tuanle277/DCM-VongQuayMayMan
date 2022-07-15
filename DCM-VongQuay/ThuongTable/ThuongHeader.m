#import "ThuongHeader.h"

@implementation ThuongHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    [NSBundle.mainBundle loadNibNamed: @"ThuongHeader" owner:self options:nil];
    [self addSubview: self.headerView];
    self.headerView.frame = self.bounds;
    self.headerView.layer.borderWidth = 1.0;
    self.phanThuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.thoiGianLabel.adjustsFontSizeToFitWidth = TRUE;
    return self;
}

@end
