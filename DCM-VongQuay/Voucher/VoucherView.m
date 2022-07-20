#import "VoucherView.h"


@interface VoucherView()
{
    UIView *backgroundView;
    UIView *superview;
    UIView *titleView;
    UIButton *submitBtn;
    UITextField *voucherTxtFld;
    UIView *decisionView;
    UILabel *decisionLabel;
}

@end

@implementation VoucherView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    superview = [UIApplication sharedApplication].keyWindow;
    [self configureBackground: frame];
    [self configureTitle];
    [self configureDecisionView];
    self.backgroundColor = [UIColor colorWithRed: 0.8 green:0.0 blue:0.0 alpha:0.3];
    [superview addSubview: self];
    [superview addSubview: titleView];
    [superview addSubview: backgroundView];

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
    titleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.7
                     animations:^{
                         self->titleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }];
}

- (void)configureBackground: (CGRect) frame
{
    backgroundView = [[UIView alloc] initWithFrame: frame];
    backgroundView.backgroundColor = UIColor.whiteColor;
    backgroundView.layer.borderWidth = 2.0;
    [self configureTextField];
    [self configureSubmitButton];
}

- (void)configureTitle
{
    titleView = [[UIView alloc] initWithFrame: CGRectMake(backgroundView.frame.origin.x + backgroundView.frame.size.width / 4, backgroundView.frame.origin.y - backgroundView.frame.size.height / 4, backgroundView.frame.size.width / 2, backgroundView.frame.size.height / 4)];
    titleView.backgroundColor = UIColor.whiteColor;
    titleView.layer.borderWidth = 2.0;
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(titleView.bounds.origin.x, titleView.frame.size.height / 4, titleView.frame.size.width, titleView.frame.size.height / 2)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColor.blackColor;
    title.adjustsFontSizeToFitWidth = TRUE;
    title.text = @"Voucher";

    [titleView addSubview: title];
}

- (void) configureTextField
{
    voucherTxtFld = [[UITextField alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x + backgroundView.frame.size.width / 10, backgroundView.bounds.origin.y + backgroundView.frame.size.height * 3 / 8, backgroundView.frame.size.width * 4 / 5, backgroundView.frame.size.height / 4)];
    voucherTxtFld.layer.borderWidth = 1.0;
    voucherTxtFld.placeholder = @"Vui lòng nhập mã trò chơi";
    voucherTxtFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [backgroundView addSubview: voucherTxtFld];
}

- (void) configureSubmitButton
{
    submitBtn = [[UIButton alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x + backgroundView.frame.size.width * 3 / 8, backgroundView.bounds.origin.y + backgroundView.frame.size.height * 5 / 7, backgroundView.frame.size.width / 4, backgroundView.frame.size.height / 6)];
    submitBtn.backgroundColor = [UIColor colorWithRed: 0.1 green:0.45 blue:0.1 alpha: 1];
    submitBtn.exclusiveTouch = TRUE;
    submitBtn.layer.cornerRadius = backgroundView.frame.size.height / 24;
    submitBtn.clipsToBounds = TRUE;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize: submitBtn.frame.size.width / 5];
    [submitBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle: @"Đồng ý" forState: UIControlStateNormal];
    [backgroundView addSubview: submitBtn];
}

-(void) buttonClicked:(UIButton*)sender
 {
     if (voucherTxtFld.text.length > 0)
     {
         if ([voucherTxtFld.text isEqualToString: @"voucher"])
         {
             decisionLabel.text = @"Chúc mừng bạn được cộng một lượt chơi";
             [self.delegate tangLuotQuay];
         }
         else
         {
             decisionLabel.text = @"Mã voucher không hợp lệ";
         }
         [superview addSubview: decisionView];
         decisionView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
         [UIView animateWithDuration:0.7
                          animations:^{
                              self->decisionView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                          }];
         submitBtn.enabled = false;
     }
 }

- (void)configureDecisionView;
{
    decisionView = [[UIView alloc] initWithFrame: CGRectMake(backgroundView.frame.origin.x, backgroundView.frame.origin.y + backgroundView.frame.size.height * 3 / 8, backgroundView.frame.size.width, backgroundView.frame.size.height / 4)];
    decisionView.backgroundColor = UIColor.blackColor;
    decisionView.layer.borderWidth = 2.0;
    decisionLabel = [[UILabel alloc] initWithFrame: CGRectMake(decisionView.bounds.origin.x + decisionView.frame.size.width / 12, decisionView.bounds.origin.y + decisionView.frame.size.height / 16, decisionView.frame.size.width * 5/ 6, decisionView.frame.size.height * 7/8)];
    decisionLabel.adjustsFontSizeToFitWidth = TRUE;
    decisionLabel.textAlignment = NSTextAlignmentCenter;
    decisionLabel.textColor = UIColor.whiteColor;
    decisionLabel.font = [UIFont systemFontOfSize: decisionLabel.frame.size.height weight: UIFontWeightBold];
    [decisionView addSubview: decisionLabel];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    decisionView.hidden = TRUE;
    self.hidden = TRUE;
    backgroundView.hidden = TRUE;
    titleView.hidden = TRUE;
    submitBtn.enabled = true;
}



@end
