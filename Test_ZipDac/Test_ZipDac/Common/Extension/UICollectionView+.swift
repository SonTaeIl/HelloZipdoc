//
//  UICollectionView+.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/10.
//

import UIKit

// MARK: - Register
extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: Identifiable {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
}

// MARK: - Dequeue
extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: Identifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
        else { fatalError("'\(T.identifier)' dequeue failure.") }
        
        return cell
    }
}
