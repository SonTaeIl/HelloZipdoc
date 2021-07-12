//
//  UIImageView+.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/10.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(urlString: String) {
        self.kf.cancelDownloadTask()
        
        guard let url = URL(string: urlString)
        else {
            self.image = nil
            return
        }
        
        self.kf.setImage(with: url)
    }
    
    func setImage(urlString: String, placeholderImageName: String) {
        self.kf.cancelDownloadTask()
        
        guard let url = URL(string: urlString)
        else {
            self.image = nil
            return
        }
        
        let placeholder = !placeholderImageName.isEmpty ? UIImage(named: placeholderImageName) : nil
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
