//
//  Airline.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import ObjectMapper

struct Airline:Mappable {
    
    var code:String = ""
    var name:String = ""
    var imagePath:String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        imagePath <- map["image"]
    }
}
