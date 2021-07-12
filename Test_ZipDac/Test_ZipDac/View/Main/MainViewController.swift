//
//  ViewController.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/09.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class MainViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchButton: UIButton!

    // Rx
    private var viewModel: MainViewModel?
    private let disposeBag: DisposeBag = DisposeBag()
    
    // Loading Bar
    private var indicatorView : NVActivityIndicatorView?
    
    private let baseURL: String = "https://search.naver.com/search.naver?where=image&sm=tab_jum&query=%EC%A7%91%EB%8B%A5"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        bindInput()
        bindOutput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: baseURL)!))
    }

    private func bindInput() {
        searchButton.rx.tap
            .map { [weak self] in
                guard let self = self else { return }
                
                self.showIndicator()
                self.webView.getHtmlString( completionHandler: { (data) in
                    self.viewModel?.transHtmlToImageList(data)
                })
            }
            .bind(to: viewModel!.input.searchTrigger)
            .disposed(by: disposeBag)
        
    }
    
    private func bindOutput() {
        viewModel?.output.searchCompleted
            .observeOn(MainScheduler())
            .subscribe { [weak self] result in
                
                guard let self = self else { return }
                self.hideIndicator()
                
                switch result.element! {
                case CompleteType.Success:
                    let storyboard = UIStoryboard(name: "Result", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController
                    self.navigationController?.pushViewController(viewController!, animated: true)
                    
                case CompleteType.Error:
                    let popupView = NotificationPopup()
                    popupView.setTitle(NSString(utf8String: result.element!.description) as String?)
                    popupView.modalPresentationStyle = .overFullScreen
                    self.navigationController?.present(popupView, animated: false, completion: nil)
                    
                default: print("Initialize")
                }
            }.disposed(by: disposeBag)
    }
    
    private func showIndicator() {
        let indi = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        indi.type = .circleStrokeSpin
        indi.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        indi.color = UIColor.orange
        indi.startAnimating()
        self.view.addSubview(indi)
        indicatorView = indi
    }
    
    private func hideIndicator() {
        indicatorView?.stopAnimating()
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}

extension MainViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page Loading Ended")
    }
}
