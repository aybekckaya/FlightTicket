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
    var durationInMinutes:Int = 0
    var flightAttributes:FlightAttributes?
    var flightNumber:String = ""
    var isPromo:Bool = false
    var isReservable:Bool = false
    var priceCurrency:String = ""
    var ticketClass:String = ""
    var timeArrival:String = ""
    var timeDeparture:String = ""
    
    // gettable properties
    
    var durationFlight:String {
        get { return minutesToHumanReadableDateString(minutes: durationInMinutes) }
    }
    
    var priceString:String {
        get { return  String(format: "%.02f", detailPrice)+" TL" }
    }
    
    init?(map: Map) { }
    
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
        durationInMinutes <- map["segments.0.duration.total_minutes"]
        flightAttributes <- map["segments.0.segment_attributes"]
    }
    
    private func minutesToHumanReadableDateString(minutes:Int)->String {
        let days = minutes / (60*24)
        let hour = (minutes - days*60*24) / 60
        let min = minutes - hour*60
       
        var strDate = String(describing:min)+"dk"
        if hour > 0 { strDate = String(describing:hour)+"sa "+strDate }
        if days > 0 { strDate = String(describing:days)+"gu "+strDate }
        
        return strDate
    }
    
}
