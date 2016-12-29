//
//  Entry+Additions.swift
//  GoodGirlOrBoy
//
//  Created by Eric Chang on 12/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

extension Entry {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        date = NSDate()
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var dateString: String? {
        return date.map { Entry.dateFormatter.string(from: $0 as Date) }
    }
    
    // MARK: - Section Names
    
    private static let sectionNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MMMM-DD"
        return formatter
    }()
    
    private static let sectionTitleFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    static func sectionTitle(for sectionName: String?) -> String? {
        let date = sectionName.flatMap { Entry.sectionNameFormatter.date(from: $0) }
        return date.map { Entry.sectionTitleFormatter.string(from: $0) }
    }
    
    var sectionName: String? {
        return date.map { Entry.sectionNameFormatter.string(from: $0 as Date) }
    }
}


