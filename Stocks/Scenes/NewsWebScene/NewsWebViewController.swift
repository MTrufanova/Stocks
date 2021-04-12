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
    
    private let url: URL
    
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        newsWKWebView.load(URLRequest(url: url))
        setupWebView()
    }
    
    func setupWebView() {
        view.addSubview(newsWKWebView)
        newsWKWebView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
    }
    
    @objc func didTapRefreshButton() {
        newsWKWebView.load(URLRequest(url: url))
    }
}

