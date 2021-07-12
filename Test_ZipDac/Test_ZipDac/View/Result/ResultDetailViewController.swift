//
//  DetailViewController.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/09.
//

import UIKit
import RxSwift

class ResultDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    var imageURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateImageScrollViewZoomScale()
    }
    
    private func bind() {
        closeButton.rx.tap
            .subscribe{ [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    private func updateImageScrollViewZoomScale() {
        if let imageURL = imageURL {
            imageView.setImage(urlString: imageURL)
            
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1
            scrollView.zoomScale = 1
            scrollView.maximumZoomScale = 3.0
        }
    }
}

// MARK: - Zoom
extension ResultDetailViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { return imageView }
}
