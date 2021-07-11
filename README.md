## HelloZipdoc


    Project : Zipdac TEST
      - SPM 사용하려했으나 Pod 사용
      - 팝업 : Objective C Bridging Header 사용하여 불러오도록 작성 ( Swift에서 Objective C - View 생성)

    개요
      - URL을 통해 집닥 관련 이미지만 추출하여 리스트에 표시 ( 비율 유지 )
      - 캐시를 통한 이미지 관리
      - 사진 클릭시 -> 전체 화면 변경해서 보이기
    
    문제 
      - Alamofire, URLSession을 사용해도 첫 번째 응답을 가져옴 : JavaScript 응답이 뿌려지기전에 가져옴
      
