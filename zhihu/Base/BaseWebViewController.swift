//
//  BaseWebViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/15.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
import JXSegmentedView

class BaseWebViewController: BaseViewController {
        var url = ""
        lazy var webView : WKWebView = {
            let webConfiguration = WKWebViewConfiguration()
            let wkUserContentController = WKUserContentController()
            wkUserContentController.add(self as WKScriptMessageHandler, name: "JavaScriptBridge")
            webConfiguration.userContentController = wkUserContentController
            webConfiguration.allowsInlineMediaPlayback = false
            webConfiguration.allowsAirPlayForMediaPlayback = false
            let web =  WKWebView(frame: .null, configuration: webConfiguration)
            web.navigationDelegate = self
            web.uiDelegate = self
            return web
        }()
        
        lazy var progressView:UIProgressView = {
            let progress = UIProgressView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1))
            progress.isHidden = false
            progress.progressTintColor = UIColor.blue
            progress.trackTintColor = .clear
            return progress
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(navigationBack))
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            guard url.count > 0 else {return}
        }
       
        override func configUI() {
            
            let myURL: URL?
            let myRequest: URLRequest?
            if !url.urldecodeString().isEmpty {
                if verifyUrl(urlString: url.urldecodeString()) {
                    myURL = URL(string:url.urldecodeString())
                    myRequest = URLRequest(url: myURL!)
                    webView.load(myRequest!)
                }else{
                    SVProgressHUD.showInfo(withStatus:"无效链接")
                }
            }

            view.addSubview(webView)
            webView.snp.makeConstraints {
                $0.width.top.centerX.equalToSuperview()
                $0.bottom.equalTo(UIDevice.current.isX() ? -34.0 : 0.0)
            }
            view.addSubview(progressView)
            
            webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            UIView.animate(withDuration: 1.0) {
                self.progressView.progress = 0.0
            }
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        func verifyUrl (urlString: String?) -> Bool {
            if let urlString = urlString {
                if let url = URL(string: urlString) {
                    return UIApplication.shared.canOpenURL(url)
                }
            }
            return false
        }
        @objc func navigationBack(){
            if webView.canGoBack {
                webView.goBack()
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                self.progressView.progress = Float(self.webView.estimatedProgress)
                if self.progressView.progress == 1 {
                    /*
                     *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
                     *动画时长0.25s，延时0.3s后开始动画
                     *动画结束后将progressView隐藏
                     */
                    UIView.animate(withDuration: 0.25, delay: 0.3, options: .curveEaseOut, animations: { [weak self] in
                        self?.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
                    }) { [weak self] _ in
                        self?.progressView.isHidden = true
                    }
                }
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }
        
        deinit {
            webView.configuration.userContentController.removeScriptMessageHandler(forName: "JavaScriptBridge")
            print("WKWebViewController is deinit")
            self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        }
    }

    extension BaseWebViewController : WKNavigationDelegate{
        // 页面开始加载时调用
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
            self.navigationItem.title = "加载中..."
            self.progressView.isHidden = false
            self.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
            
            
        }
        // 当内容开始返回时调用
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
           
        }
        // 页面加载完成之后调用
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
            /// 获取网页title
            self.navigationItem.title = self.webView.title
            UIView.animate(withDuration: 0.5) {
                self.progressView.progress = 1.0
                self.progressView.isHidden = true
            }
            
            self.webView.evaluateJavaScript("document.getElementsByClassName('MobileAppHeader')[0].style.display= 'none'", completionHandler: nil)
            self.webView.evaluateJavaScript("document.getElementsByClassName('MobileModal-wrapper')[0].style.display= 'none'", completionHandler: nil)
            self.webView.evaluateJavaScript("document.getElementsByClassName('OpenInAppButton')[0].style.display= 'none'", completionHandler: nil)
        }
        // 页面加载失败时调用
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
            
            UIView.animate(withDuration: 0.5) {
                self.progressView.progress = 0.0
                self.progressView.isHidden = true
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
    //        if let url = navigationAction.request.url {
    //            if url.scheme == "tel" {
    //                UIApplication.shared.openURL(url)
    //                decisionHandler(WKNavigationActionPolicy.cancel)
    //                return
    //            }
    //        }
            decisionHandler(WKNavigationActionPolicy.allow)
        }
        
    }

    extension BaseWebViewController : WKUIDelegate {
        
        /** 对html中blank标签处理 */
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame?.isMainFrame == nil {
                //            webView.load(navigationAction.request)
                let webVc = BaseWebViewController()
                webVc.url = navigationAction.request.url?.absoluteString ?? ""
                self.navigationController?.pushViewController(webVc, animated: true)
            }
            return nil
        }
    }
    extension BaseWebViewController : WKScriptMessageHandler {
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            
            if let dic = message.body as? [String: Any] {
                let sel = (dic["sel"] ?? "") as! String
                if sel == "navigateToPayPage" {
//                    let vc = EBPayViewController()
//                    vc.orderId = orderId
//                    self.navigationController?.pushViewController(vc, animated: true)
                }

            }
            
        }
    }

extension BaseWebViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
