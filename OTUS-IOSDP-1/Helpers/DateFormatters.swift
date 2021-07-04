//
//  DateFormatters.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation

fileprivate var RFC3339DateFormatDefault = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

extension JSONDecoder {

    /// Assign multiple DateFormatter to dateDecodingStrategy
    ///
    /// Usage :
    ///
    ///      decoder.dateDecodingStrategyFormatters = [ DateFormatter.standard, DateFormatter.yearMonthDay ]
    ///
    /// The decoder will now be able to decode two DateFormat, the 'standard' one and the 'yearMonthDay'
    ///
    /// Throws a 'DecodingError.dataCorruptedError' if an unsupported date format is found while parsing the document
    var dateDecodingStrategyFormatters: [DateFormatter]? {
        @available(*, unavailable, message: "This variable is meant to be set only")
        get { return nil }
        set {
            guard let formatters = newValue else { return }
            self.dateDecodingStrategy = .custom { decoder in

                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)

                for formatter in formatters {
                    if let date = formatter.date(from: dateString) {
                        return date
                    }
                }

                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            }
        }
    }
}

extension DateFormatter {
    static var RFC3339DateFormatterDefault: DateFormatter {
        let enUSPOSIXLocale: Locale? = Locale(identifier: "en_US_POSIX")
        assert(enUSPOSIXLocale != nil, "enUSPOSIXLocale must not be nil")
        
        let dateFormatter:DateFormatter? = DateFormatter()
        assert(dateFormatter != nil, "dateFormatter must not be nil")
        
        dateFormatter!.locale = enUSPOSIXLocale
        dateFormatter!.dateFormat = RFC3339DateFormatDefault
        dateFormatter!.timeZone = TimeZone(secondsFromGMT:0)
        
        return dateFormatter!
    }
}

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}


extension DateFormatter {
    static let iso8601Full2: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZZ"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
}

extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
