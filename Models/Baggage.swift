//
//  Baggage.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import ObjectMapper

struct Baggage:Mappable {
    
    var paxType:String = ""
    var allowance:Float = 0
    var type:String = ""
    var unit:String = ""
    var part:Int = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        paxType <- map["paxType"]
        allowance <- map["allowance"]
        type <- map["type"]
        unit <- map["unit"]
        part <- map["part"]
    }
    
   
    
}

