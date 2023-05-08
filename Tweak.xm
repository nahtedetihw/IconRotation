#import <UIKit/UIKit.h>

@interface SBIcon : NSObject
@property (nonatomic) NSUInteger gridSizeClass;
@end

@interface SBWidgetIcon : SBIcon
@property (nonatomic) NSUInteger gridSizeClass;
@end

@interface SBIconView : UIView
@property (nonatomic) SBIcon *icon;
@property (nonatomic) NSString *location;
@property (assign,nonatomic) BOOL isEditing;
- (void)orientationChanged;
@end

%hook SBIconView
- (void)didMoveToWindow {
    %orig;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (void)didMoveToSuperview {
    %orig;
    [self orientationChanged];
}

%new
- (void)orientationChanged {
    if (self.isEditing == YES) return;
    if ([NSStringFromClass([self.icon class]) isEqualToString:@"SBWidgetIcon"] && self.icon.gridSizeClass == 2) return;
    if ([self.location isEqual:@"SBIconLocationRoot"] || [self.location isEqual:@"SBIconLocationFloatingDock"] || [self.location isEqual:@"SBIconLocationDock"] || [self.location isEqual:@"SBIconLocationFloatingDockSuggestions"]) {
        if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft){
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:nil animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI / -2);
            } completion:nil];
        } else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight) {
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:nil animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
            } completion:nil];
        } else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait) {
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:nil animations:^{
                self.transform = CGAffineTransformMakeRotation(0);
            } completion:nil];
        } else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:nil animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:nil];
        }
    }
}
%end
