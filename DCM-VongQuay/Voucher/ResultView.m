#import "ResultView.h"

@interface ResultView ()
{
    UIView *superview;
    UIView *backgroundView;
    UILabel *title;
    UILabel *message;
}

@end

@implementation ResultView

- (id) initWithFrame:(CGRect)frame withTitle:(NSString *)titleString andMessage: (NSString *) messageString
{
    self = [super initWithFrame: frame];
    superview = [UIApplication sharedApplication].keyWindow;
    [self configureBackground: frame];
    [self configureTitle: titleString];
    [self configureMessage: messageString];
    self.backgroundColor = [UIColor colorWithRed: 0.8 green:0.0 blue:0.0 alpha:0.3];
    [superview addSubview: self];
    [superview addSubview: backgroundView];
    [backgroundView addSubview: title];
    [backgroundView addSubview: message];
    return self;
}

- (void)show
{
    self.frame = superview.bounds;
    backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.7
                     animations:^{
                         self->backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }];
}

- (void)configureBackground: (CGRect) frame
{
    backgroundView = [[UIView alloc] initWithFrame: frame];
    backgroundView.backgroundColor = UIColor.whiteColor;
    backgroundView.layer.borderWidth = 1.0;
    backgroundView.layer.cornerRadius = backgroundView.frame.size.height / 3;
}

- (void) configureTitle: (NSString *) titleString
{
    title = [[UILabel alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y + backgroundView.frame.size.height * 1 / 8, backgroundView.frame.size.width, backgroundView.frame.size.height / 2)];
    title.text = titleString;
    title.font = [UIFont systemFontOfSize: backgroundView.frame.size.height / 10];
    title.adjustsFontSizeToFitWidth = true;
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
}

- (void) configureMessage: (NSString *) messageString
{
    message = [[UILabel alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x + backgroundView.frame.size.width / 8, backgroundView.bounds.origin.y + backgroundView.frame.size.height * 11 / 20, backgroundView.frame.size.width * 3 / 4, backgroundView.frame.size.height / 3)];
    message.text = messageString;
    message.font = [UIFont systemFontOfSize: backgroundView.frame.size.height / 4 weight: UIFontWeightBold];
    message.numberOfLines = 0;
    message.adjustsFontSizeToFitWidth = true;
    message.textAlignment = NSTextAlignmentCenter;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = TRUE;
    backgroundView.hidden = TRUE;
}

@end
