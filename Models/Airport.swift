//
//  Airport.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import ObjectMapper

struct Airport:Mappable {
    
    var airportCode:String = ""
    var airportName:String = ""
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        airportCode <- map["airport_code"]
        airportName <- map["airport_name"]
    }
}
