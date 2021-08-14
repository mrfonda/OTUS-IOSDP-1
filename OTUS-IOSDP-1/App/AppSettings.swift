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
    let holidaysAPIKey: String = "795f8ae2b5a189b4a0099ad23cde03c9d18e1732"
    let neighboursAPIKey: String = "QH9NHHADR1ZRKIRJBEMQ6GFKL9LZVGK4"
    private init() {}
}
