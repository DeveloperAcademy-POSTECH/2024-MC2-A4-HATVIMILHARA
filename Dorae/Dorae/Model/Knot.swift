//
//  Knot.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation



enum 매듭 {
    case 기본(매듭: 기본), 응용(매듭: 응용), 길이(매듭: 길이), 끈목(매듭: 끈목), 술(매듭: 술)
}

struct 기본 {
    let 매듭이름: String
    let 매듭이미지: String
    var 귀: [String] = []
}

struct 응용 {
    let 매듭이름: String
    let 매듭이미지: String
    var 하위매듭리스트: [String] = []
}

struct 길이 {
    var 끈길이: Float
}

enum 끈목 {
    case 극세사, 세사, 중사, 중세사, 태사, 극테사
}

enum 술 {
    case 딸기술, 봉술, 방망이술, 낙지발술, 방울술, 전복술, 금전지술, 잔술

}
