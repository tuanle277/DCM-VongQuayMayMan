#import "CoCauHeader.h"

@implementation CoCauHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    [NSBundle.mainBundle loadNibNamed: @"CoCauHeader" owner:self options:nil];
    [self addSubview: self.headerView];
    self.headerView.frame = self.bounds;
    self.headerView.layer.borderWidth = 1.0;
    self.coCauLabel.adjustsFontSizeToFitWidth = TRUE;
    self.giaiThuongLabel.adjustsFontSizeToFitWidth = TRUE;
    self.soLuongLabel.adjustsFontSizeToFitWidth = TRUE;
    return self;
}





@end
