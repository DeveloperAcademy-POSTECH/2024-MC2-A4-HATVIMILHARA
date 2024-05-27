//
//  Date+.swift
//  Dorae
//
//  Created by 지영 on 5/27/24.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func StringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.date(from: self)
    }
}
