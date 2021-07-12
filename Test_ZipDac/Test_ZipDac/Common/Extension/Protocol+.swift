//
//  Protocol+.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/10.
//

import UIKit

// MARK: - Identifiable
protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
