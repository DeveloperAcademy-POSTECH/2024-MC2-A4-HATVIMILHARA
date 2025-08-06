//
//  KnotFactory.swift
//  Dorae
//
//  Created by Milou on 8/6/25.
//

import Foundation

struct KnotFactory {
    
    // O(1) 접근을 위한 Dictionary 매핑
    private static let basicKnotMap: [String: BasicKnot] = {
        Dictionary(uniqueKeysWithValues: basicKnotCollection
            .map { ($0.knotName.rawValue, $0) })
    }()
    
    private static let appliedKnotMap: [String: AppliedKnot] = {
        Dictionary(uniqueKeysWithValues: appliedKnotCollection
            .map { ($0.knotName.rawValue, $0) })
    }()
    
    private static let templateMap: [String: Pattern] = {
        Dictionary(uniqueKeysWithValues: Pattern.predefinedTemplates
            .map { ($0.title, $0) })
    }()
    
    /// 매듭 이름과 카테고리로 새로운 Knot 인스턴스 생성
    static func createKnot(name: String, category: KnotCategory) -> Knot? {
        switch category {
        case .basicCategory:
            return basicKnotMap[name].map {
                .basic(knot: BasicKnot(basicKnot: $0))
            }
        case .appliedCategory:
            return appliedKnotMap[name].map {
                .applied(knot: AppliedKnot(appliedKnot: $0))
            }
        case .etcCategory:
            switch name {
            case "고": return .etc(knot: EtcKnot(lasso: name))
            case "술": return .etc(knot: EtcKnot(tassel: name))
            case "간격": return .etc(knot: EtcKnot(interval: 0.0))
            default: return nil
            }
        case .templateCategory:
            return nil
        }
    }
    
    static func createKnotList(templateName: String) -> [Knot] {
        return templateMap[templateName]?.knotList ?? []
    }
}
