#import <UIKit/UIKit.h>

@interface VongQuayViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIButton *coCaubtn;
@property (weak, nonatomic) IBOutlet UIButton *trungGiaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *thuongBtn;
@property (weak, nonatomic) IBOutlet UIButton *spinBtn;
@property (weak, nonatomic) IBOutlet UILabel *lanQuayLabel;
@property (weak, nonatomic) IBOutlet UIView *titleBackGroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *introTitle;
@property (weak, nonatomic) IBOutlet UILabel *coCauLabel;
@property (weak, nonatomic) IBOutlet UILabel *trungGiaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *thuongLabel;
@property (weak, nonatomic) IBOutlet UIView *lanQuayContainer;
@property (weak, nonatomic) IBOutlet UIButton *lanQuayBtn;
@property (weak, nonatomic) IBOutlet UILabel *lanQuayLbl;

@property (nonatomic, strong) UILabel *sectorLabel;
@property CGFloat screenHeight;
@property CGFloat screenWidth;

@property (weak, nonatomic) IBOutlet UIView *buttonsContainer;
- (IBAction)coCauAction:(UIButton *)sender;
- (IBAction)trungGiaiAction:(UIButton *)sender;
- (IBAction)thuongAction:(UIButton *)sender;
- (IBAction)tangLuotQuayAction:(UIButton *)sender;
- (IBAction)spinAction:(UIButton *)sender;

@end

