#import <UIKit/UIKit.h>

@interface SBIconView : UIView
@property (nonatomic) NSString *location;
@end

%hook SBIconView
- (void)didMoveToWindow {
    %orig;
    if ([self.location isEqual:@"SBIconLocationRoot"] || [self.location isEqual:@"SBIconLocationFloatingDock"] || [self.location isEqual:@"SBIconLocationDock"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
}

%new
- (void)orientationChanged {
    if ([self.location isEqual:@"SBIconLocationRoot"] || [self.location isEqual:@"SBIconLocationFloatingDock"] || [self.location isEqual:@"SBIconLocationDock"]) {
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
