//
//  AppSettings.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 23/07/2021.
//

import Foundation

class AppSettings {
    static let shared: AppSettings = AppSettings()
    let newsAPIKey: String = "5495b4de51dc46ecb2ecfad735a66bab"
    
    private init() {}
}
