
#import <WebKit/WebKit.h>
#import <BlocksKit/BlocksKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (BlocksKit)

@property(nonatomic, copy, nullable) BOOL (^bk_shouldStartLoadBlock)(WKWebView *webView, WKNavigationAction *navigationAction);
@property(nonatomic, copy, nullable) void (^bk_didStartLoadBlock)(WKWebView *webView, WKNavigation *navigation);
@property(nonatomic, copy, nullable) void (^bk_didFinishLoadBlock)(WKWebView *webView, WKNavigation *navigation);
@property(nonatomic, copy, nullable) void (^bk_didFinishWithErrorBlock)(WKWebView *webView, WKNavigation *navigation, NSError *error);

@end

NS_ASSUME_NONNULL_END
