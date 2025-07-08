//
//  String+.swift
//  Dorae
//
//  Created by Milou on 7/6/25.
//

import Foundation

extension String {
    @inlinable static func localized(_ s: String.LocalizationValue) -> String {
        String(localized: s)
    }
    
    var asLocalizedKnotName: String {
        if let basicKnot = BasicKnotName(rawValue: self) {
            return basicKnot.localizedName
        } else if let appliedKnot = AppliedKnotName(rawValue: self) {
            return appliedKnot.localizedName
        } else if let etcKnot = EtcKnotName(rawValue: self) {
            return etcKnot.localizedName
        }
        return self
    }
}
