//
//  DateFormatter+.swift
//  Dorae
//
//  Created by 지영 on 5/27/24.
//

import Foundation

extension DateFormatter {
    static var patternDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        return dateFormatter
    }
}
