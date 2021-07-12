//
//  AppDelegate.swift
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/09.
//

import UIKit

/*
  Project : Zipdac TEST
    - SPM 사용하려했으나... Pod 사용
    - 팝업 : Objective C Bridging Header 사용하여 불러오도록 작성
    - MVVM 사용
    - Zoom 지원
 
  개요
    - URL을 통해 집닥 관련 이미지만 추출하여 리스트에 표시 ( 비율 유지 )
    - 캐시를 통한 이미지 관리
    - 사진 클릭시 -> 전체 화면 변경해서 보이기
 */
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

