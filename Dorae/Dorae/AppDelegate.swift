//
//  Untitled.swift
//  Dorae
//
//  Created by yegang on 8/6/25.
//

import Mixpanel
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Mixpanel.initialize(token: PrivateKey.getMixpanel ?? "", trackAutomaticEvents: false)
        Mixpanel.mainInstance().useIPAddressForGeoLocation = false
        return true
    }
}
