//
//  MixpanelService.swift
//  Dorae
//
//  Created by yegang on 8/6/25.
//

import Foundation
import Mixpanel

final class MixpanelService {
    static let shared = MixpanelService()

    private init() {}

    func trackTemplateButton(category: String) {
        Mixpanel.mainInstance().track(event: "TemplateButtonClicked", properties: [
            "template": category
        ])
    }
}
