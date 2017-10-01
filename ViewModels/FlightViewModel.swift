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
        
        let modelsFlight:[Flight] = flightsRaw.flatMap{
            let dct = $0.dictionaryObject
            let theModel = Mapper<Flight>().map(JSON: dct!)
            return theModel
        }
        
        print("sample Model : \(modelsFlight[0])")
        flights.onNext(modelsFlight)
    }
    
}
