#import <UIKit/UIKit.h>

@interface VongQuayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *coCaubtn;
@property (weak, nonatomic) IBOutlet UIButton *trungGiaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *thuongBtn;
@property (weak, nonatomic) IBOutlet UIButton *spinBtn;
@property (weak, nonatomic) IBOutlet UILabel *lanQuayLabel;

@property (nonatomic, strong) UILabel *sectorLabel;

- (IBAction)coCauAction:(UIButton *)sender;
- (IBAction)trungGiaiAction:(UIButton *)sender;
- (IBAction)thuongAction:(UIButton *)sender;
- (IBAction)tangLuotQuayAction:(UIButton *)sender;
- (IBAction)spinAction:(UIButton *)sender;




@end

