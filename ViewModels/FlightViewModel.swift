//
//  FlightViewModel.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper


enum SceneType {
    case departureScene
    case returnScene
}

struct FlightViewModel {
    
    lazy var json: JSON? = {
        guard let jsonFile = Bundle.main.url(forResource: "SearchResults", withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: jsonFile)
            return try JSON(data: data)
        }catch {
            return nil
        }
    }()
    
    
    var dctAirports:[String:Airport]?
    var dctAirlines:[String:Airline]?
    
    var flights = BehaviorSubject<[Flight]>(value:[])
 
    var typeScene:SceneType = SceneType.departureScene
    
    mutating func initializeFlightData() {
       
        guard let jsonData = json else { fatalError("json cannot produced") }
        guard let flightsRaw = typeScene == .departureScene ? jsonData["flights"]["departure"].array : jsonData["flights"]["return"].array else { fatalError("flight data cannot be get") }
        
        if let airlinesRaw = jsonData["airlines"].dictionary {
             dctAirlines = [:]
             airlinesRaw.keys.flatMap{
                guard let data = airlinesRaw[$0]?.dictionaryObject else { return nil }
                let model = Mapper<Airline>().map(JSON:data)
                return model
                }.forEach{
                    self.dctAirlines![$0.code] = $0
                }
        }
        
        if let airportsRaw = jsonData["airports"].dictionary {
            dctAirports = [:]
            airportsRaw.keys.flatMap{
                guard let data = airportsRaw[$0]?.dictionaryObject else { return nil }
                let model = Mapper<Airport>().map(JSON:data)
                return model
                }.forEach{
                     self.dctAirports![$0.airportCode] = $0
                }
        }
        
        
        let modelsFlight:[Flight] = flightsRaw.flatMap{
            let dct = $0.dictionaryObject
            let theModel = Mapper<Flight>().map(JSON: dct!)
            var modelFinal = theModel
            modelFinal?.airlineFlight = self.dctAirlines?[theModel?.airlineCode ?? ""]
            modelFinal?.airportOrigin = self.dctAirports?[theModel?.airportOriginCode ?? ""]
            modelFinal?.airportDestination = self.dctAirports?[theModel?.airportDestinationCode ?? ""]
            return modelFinal
        }
        
        flights.onNext(modelsFlight)
    }
    
}
