//
//  Webkit+.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/12.
//

import WebKit

extension WKWebView {
    func getHtmlString(completionHandler: @escaping (String) -> Void) {
        self.evaluateJavaScript("document.body.innerHTML", completionHandler: { (result, error) in
            if let result = result as? String {
                completionHandler(result)
            }
            else {
                completionHandler("")
            }
        })
    }
}
