//
//  ResultViewCell.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/12.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell, Identifiable {

    private var imageView : UIImageView?
    var imageURL: String? {
        didSet {
            imageView?.image = nil
            
            guard let imageURL = imageURL else { return }
            
            imageView = UIImageView()
            imageView?.setImage(urlString: imageURL)
            imageView?.contentMode = .scaleAspectFit
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(imageView!)
            
            NSLayoutConstraint.activate([
                imageView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                imageView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                imageView!.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                imageView!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            ])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
