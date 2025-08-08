//
//  PrivateKey.swift
//  Dorae
//
//  Created by yegang on 8/6/25.
//


import Foundation

enum PrivateKey {
    static var getMixpanel: String? {
        return Bundle.main.object(forInfoDictionaryKey: "MixpanelKEY") as? String
    }
}
