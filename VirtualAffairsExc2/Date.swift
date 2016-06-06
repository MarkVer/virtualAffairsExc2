//
//  Date.swift
//  VirtualAffairsExc2
//
//  Created by Mark Verwoerd on 06/06/16.
//  Copyright © 2016 Mark Verwoerd. All rights reserved.
//

import Foundation

class Date: NSObject {
    
    var beginDate: String
    var endDate: String
    
    init(beginDate: String, endDate: String) {
        self.beginDate = beginDate
        self.endDate = endDate
    }
}
