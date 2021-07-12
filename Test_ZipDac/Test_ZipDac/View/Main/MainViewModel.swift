//
//  MainViewModel.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/10.
//

import Foundation
import SwiftSoup
import RxSwift
import RxCocoa

enum CompleteType: Equatable {
    case None           // 초기화
    case Success        // 성공
    case Error(String)  // 실패
    
    var description: String {
        get {
            switch self {
            case .Error(let desc): return desc
            default: return ""
            }
        }
    }
}

protocol MainViewModelType {

    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }

    var disposeBag : DisposeBag { get set }
}

final class MainViewModel: MainViewModelType {

    struct Input {
        var searchTrigger =  PublishSubject<Void>()
    }

    struct Output {
        var searchCompleted = BehaviorRelay<CompleteType>(value: .None)
    }

    var input: Input
    var output: Output
    var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        input = Input()
        output = Output()
    }

    func transHtmlToImageList(_ html: String) {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let elements: Elements = try doc.select("div.api_photo_tile._grid").select("a").select("img[src]")
            
            DataManager.shard.crawlingImageUrlList = nil
            DataManager.shard.crawlingImageUrlList = elements.map { element -> String in
                do {
                    return try element.attr("src").description
                }
                catch { return "" }
            }.filter { !$0.isEmpty && !$0.contains("base64") }
            
            if DataManager.shard.crawlingImageUrlList?.count ?? 0 < 1 {
                output.searchCompleted.accept(.Error("이미지가 존재하지 않습니다."))
            }
            else {
                output.searchCompleted.accept(.Success)
            }
        }
        catch let error { output.searchCompleted.accept(.Error("\(error)")) }
    }
}
