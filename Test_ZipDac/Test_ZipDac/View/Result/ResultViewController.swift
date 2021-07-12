//
//  ResultViewController.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/10.
//

import UIKit
import RxSwift
import RxDataSources

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var currentIdx: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultCountLabel.text = "전체 \(DataManager.shard.crawlingImageUrlList?.count ?? 0)개"
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func bind() {
        
        collectionView.register(ResultCollectionViewCell.self)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable.just( DataManager.shard.crawlingImageUrlList!)
            .bind(to: collectionView.rx.items) { (collectionView, row, element) in
                let cell = collectionView.dequeueReusableCell(ResultCollectionViewCell.self, for: IndexPath(index: row))
                cell.imageURL = element
                return cell
        }.disposed(by: disposeBag)
        
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(String.self))
            .bind { [weak self] indexPath, data in
                
                guard let self = self else { return }
            
                if Int(self.currentIdx) != indexPath.row {
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    self.currentIdx = CGFloat(indexPath.row)
                }
                else {
                    let storyboard = UIStoryboard(name: "Result", bundle: nil)
                    if let viewController = storyboard.instantiateViewController(withIdentifier: "ResultDetailViewController") as? ResultDetailViewController {
                        viewController.imageURL = data
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true, completion: nil)
                    }
                }
            }.disposed(by: disposeBag)
    }
    
}


// MARK: - CollecionView Layout
extension ResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 24 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { .zero }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 100
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}


// MARK: - Paging
extension ResultViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let cv = scrollView as? UICollectionView {
            let cellWidth = collectionView.bounds.width - 100 + 24
            
            var offset = targetContentOffset.pointee
            let idx = round((offset.x + cv.contentInset.left) / cellWidth)
            
            if idx > currentIdx {
                currentIdx += 1
            }
            else if idx < currentIdx {
                if currentIdx != 0 {
                    currentIdx -= 1
                }
            }
            offset = CGPoint(x: currentIdx * cellWidth - cv.contentInset.left, y: 0)
            targetContentOffset.pointee = offset
        }
    }
}
