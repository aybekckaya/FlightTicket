//
//  Flight.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import ObjectMapper

struct Flight:Mappable {
    
    // settable, gettable properties
    var airlineCode:String = ""
    var airlineFlight:Airline?
    var airportDestination:Airport?
    var airportDestinationCode:String = ""
    var airportOrigin:Airport?
    var airportOriginCode:String = ""
    var availableSeats:Int = 0
    var baggageFlight:Baggage?
    var detailPrice:Float = 0
    var durationFlight:String = ""
    var flightAttributes:FlightAttributes?
    var flightNumber:String = ""
    var isPromo:Bool = false
    var isReservable:Bool = false
    var priceCurrency:String = ""
    var ticketClass:String = ""
    var timeArrival:String = ""
    var timeDeparture:String = ""
    
    // gettable properties
    var priceString:String {
        get {
             return  String(format: "%.02f", detailPrice)+" TL"
        }
    }
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        airlineCode <- map["segments.0.operating_airline"]
        airportOriginCode <- map["segments.0.origin"]
        airportDestinationCode <- map["segments.0.destination"]
        availableSeats <- map["segments.0.available_seats"]
        baggageFlight <- map["infos.baggage_info.firstBaggageCollection.0"]
        detailPrice <- map["detail_price"]
        priceCurrency <- map["price_currency"]
        timeArrival <- map["segments.0.arrival_datetime.time"]
        timeDeparture <- map["segments.0.departure_datetime.time"]
        
    }
}
