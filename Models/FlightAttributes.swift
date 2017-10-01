//
//  FlightAttributes.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import ObjectMapper

struct FlightAttributes:Mappable {
    
    enum EntertainmentType:String {
        case overhead = "overhead"
        case personal = "personal"
        
        func stringify()->String {
            switch self {
            case .overhead: return "video:başüstü ekran"
            case .personal: return "kişisel ekran"
            }
        }
    }
    
    enum SeatPlanTypes:String {
        case single = "3-3"
        case double = "3-3-3"
        func stringify()->String {
            switch self {
            case .single: return "Tek koridor"
            case .double: return "Çift koridor"
            }
        }
    }
    
    
    var freeMeal:Bool = false
    var seatPitch:String = ""
    var airplaneBrand:String = ""
    var entertainment:String = ""
    var wifi:String = ""
    var seatPlan:String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        freeMeal <- map["free_meal"]
        seatPitch <- map["seat_pitch"]
        airplaneBrand <- map["airplane_brand"]
        entertainment <- map["entertainment"]
        wifi <- map["wifi"]
        seatPlan <- map["seat_plan"]
    }
    
    func stringify()->String {
        var arrAttributes:[String] = []
        arrAttributes.append(freeMeal ? "yiyecekler ücretsizdir" : "")
        arrAttributes.append("Koltuk mesafesi : "+seatPitch+" cm")
        arrAttributes.append("Uçak : "+airplaneBrand)
        arrAttributes.append("Wifi :" + (wifi == "0" ? "yok":"var") )
        arrAttributes.append(EntertainmentType(rawValue: entertainment)?.stringify() ?? "")
        arrAttributes.append(SeatPlanTypes(rawValue:seatPlan)?.stringify() ?? "")
        return arrAttributes.filter{ $0 != "" }.joined(separator:", ")
    }
    
}
