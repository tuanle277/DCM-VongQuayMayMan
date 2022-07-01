#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HanhDongQuay.h"
#import "PhanVongQuay.h"

NS_ASSUME_NONNULL_BEGIN

@interface VongQuay : UIView

@property UIView *circle;
@property UIView *indicator;
@property NSMutableArray <UIColor *> *colors;
@property NSMutableArray *arrayOfSectors;
@property NSMutableArray *rewards;
@property NSTimer *timer;
@property CGFloat circleRotationInRadian;
@property float spinTime;
@property int numberOfSectors;
@property int diameter;
@property int radius;


- (void) buildCircle;
- (void) buildSectors;
- (void) buildItems;
- (void) buildUpRotation;
- (void) updateUp;
- (void) turnOffRotation;
- (void) updateDown;
- (id) initWithFrame:(CGRect)frame  withSections:(int)sectionsNumber withDiameter: (int)diameter;

//- (void) rotate;

@end

NS_ASSUME_NONNULL_END
