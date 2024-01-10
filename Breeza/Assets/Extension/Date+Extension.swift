//
//  Date+Extension.swift
//  inSchool
//
//  Created by AHMED on 7/14/19.
//  Copyright © 2019 Mohamed Khalid. All rights reserved.
//

import Foundation

extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }
    
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        return formatter
    }()
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
    }
}


extension DateFormatter {

    enum RespondseDateFormat: String {
        case tDateFormat = "yyyy-MM-dd HH:mm:ss Z"
        case tLongerFormat = "yyyy-MM-dd HH:mm:ss Z.SSS"
    }
    
    
    static let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        timeFormatter.amSymbol = "am"
        timeFormatter.pmSymbol = "pm"
        return timeFormatter
    }()
    
    static let slashDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()

    
    static func extractTime(_ dateString: String, dateFormat: RespondseDateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        
        if let date = formatter.date(from: dateString) {
            return timeFormatter.string(from: date)
        }
        return nil
    }
    
    static func extractSlashDate(_ dateString: String, dateFormat: RespondseDateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        if let date = formatter.date(from: dateString) {
            return slashDateFormatter.string(from: date)
        }
        return nil
    }
    
    static func extractDate(_ dateString: String, dateFormat: RespondseDateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        
        if let date = formatter.date(from: dateString) {
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    static func extractTDate(_ dateString: String, dateFormat: RespondseDateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        
        if let date = formatter.date(from: dateString) {
            return formatter.string(from: date)
        }
        return nil
    }
}
