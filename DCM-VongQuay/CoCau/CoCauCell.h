#import <UIKit/UIKit.h>
#import "GiaiThuongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoCauCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *giaiLabel;
@property (strong, nonatomic) IBOutlet UILabel *phanThuongLabel;
@property (strong, nonatomic) IBOutlet UILabel *soLuongLabel;

- (void) setUp: (GiaiThuong *) phanThuong withIndexPath: (NSIndexPath *) indexPath;


@end

NS_ASSUME_NONNULL_END
