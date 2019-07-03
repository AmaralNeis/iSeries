//
//  String+.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 30/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

extension String {
    
    var dateFormated: String  {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"
        
        let date: Date? = dateFormatterGet.date(from: self)
        
        if let date = date {
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
}
