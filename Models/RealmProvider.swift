//
//  RealmProvider.swift
//  FlightTicket
//
//  Created by aybek can kaya on 02/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm
import RxRealm


class RealmData:Object {
    @objc dynamic var flightJson:String = ""
}

class RealmProvider: NSObject {
   
    func ucurBeniUzaklara(_ model:Flight) {
        guard let jsonStr = model.toJSONString(prettyPrint: false) else { return }
        do {
            let dataModel = RealmData()
            dataModel.flightJson = jsonStr
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(realm.objects(RealmData.self))
            try realm.commitWrite()
            try realm.write { realm.add(dataModel) }
        }catch let error as NSError {
            print("KARDEŞ, BENİ LOGLA . LOGLAMAZSAN ARAMIZ BOZULUR. BEN KİM MİYİM? BEN :\(error). HARBİ TEHLİKELİYİM BEN BAK.")
        }
    }
    
}




