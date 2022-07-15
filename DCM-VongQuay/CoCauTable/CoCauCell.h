#import <UIKit/UIKit.h>
#import "GiaiThuongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoCauCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *giaiLabel;
@property (strong, nonatomic) IBOutlet UILabel *phanThuongLabel;
@property (strong, nonatomic) IBOutlet UILabel *soLuongLabel;
@property (strong, nonatomic) IBOutlet UIView *giaiContainer;
@property (strong, nonatomic) IBOutlet UIView *phanThuongContainer;
@property (strong, nonatomic) IBOutlet UIView *soLuongContainer;

- (void) setUp: (GiaiThuong *) phanThuong withIndexPath: (NSIndexPath *) indexPath;
+ (NSString *) identifier;

@end

NS_ASSUME_NONNULL_END
