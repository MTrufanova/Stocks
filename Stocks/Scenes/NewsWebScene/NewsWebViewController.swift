//
//  NewsWebViewController.swift
//  Stocks
//
//  Created by msc on 10.04.2021.
//

import UIKit
import WebKit
class NewsWebViewController: UIViewController {
lazy var newsWKWebView = WKWebView()
    var newsWebItem: NewsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        
    }
    
    func setupWebView() {
        view.addSubview(newsWKWebView)
        newsWKWebView.frame = view.bounds
        newsWKWebView.uiDelegate = self
        newsWKWebView.navigationDelegate = self
        guard let newsURL = URL(string: newsWebItem?.link ?? "https://www.google.ru/") else {
            return
        }
        let request = URLRequest(url: newsURL)
        newsWKWebView.load(request)
    }
    
}
extension NewsWebViewController: WKUIDelegate, WKNavigationDelegate {
    
}
