
#import "WKWebView+BlocksKit.h"
#import "A2DynamicDelegate.h"
#import "NSObject+A2DynamicDelegate.h"
#import "NSObject+A2BlockDelegate.h"

@interface A2DynamicWKWebViewDelegate : A2DynamicDelegate <WKNavigationDelegate>
@end

@implementation A2DynamicWKWebViewDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    BOOL ret = YES;
    
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)])
        [realDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];

    BOOL (^block)(WKWebView *, WKNavigationAction *) = [self blockImplementationForMethod:_cmd];
    if (block)
        ret = block(webView, navigationAction);
    
    decisionHandler(ret ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)])
        [realDelegate webView:webView didStartProvisionalNavigation:navigation];

    void (^block)(WKWebView *, WKNavigation *) = [self blockImplementationForMethod:_cmd];
    if (block) block(webView, navigation);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:didFinishNavigation:)])
        [realDelegate webView:webView didFinishNavigation:navigation];

    void (^block)(WKWebView *, WKNavigation *) = [self blockImplementationForMethod:_cmd];
    if (block) block(webView, navigation);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:didFailNavigation:withError:)])
        [realDelegate webView:webView didFailNavigation:navigation withError:error];

    void (^block)(WKWebView *, WKNavigation *, NSError *) = [self blockImplementationForMethod:_cmd];
    if (block) block(webView, navigation, error);
}

@end

@implementation WKWebView (BlocksKit)

@dynamic bk_shouldStartLoadBlock, bk_didStartLoadBlock, bk_didFinishLoadBlock, bk_didFinishWithErrorBlock;

+ (void)load
{
    @autoreleasepool {
        [self bk_registerDynamicDelegate];
        [self bk_linkDelegateMethods:@{
            @"bk_shouldStartLoadBlock": @"webView:decidePolicyForNavigationAction:decisionHandler:",
            @"bk_didStartLoadBlock": @"webView:didStartProvisionalNavigation:",
            @"bk_didFinishLoadBlock": @"webView:didFinishNavigation:",
            @"bk_didFinishWithErrorBlock": @"webView:didFailNavigation:withError:"
        }];
    }
}

@end
