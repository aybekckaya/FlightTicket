//
//  FlightVC.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class FlightVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableviewFlights: UITableView!
    
    var scene:SceneType = .departureScene
    
    
    fileprivate var viewModelFlight = FlightViewModel()
    
    fileprivate var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelFlight.typeScene = scene
        setUpTableview()
        
    }
    
    private func setUpTableview() {
        
        viewModelFlight.flights.bind(to: tableviewFlights.rx.items(cellIdentifier: FlightCell.identifier, cellType: FlightCell.self)){ (row,element,cell) in
            
            self.updateCell(cell: cell, row: row, flightModel: element)
            
            }.disposed(by: disposeBag)
        
        tableviewFlights.rx.modelSelected(Flight.self).subscribe(onNext:  { value in
            print("value selected : \(value)")
        }).disposed(by: disposeBag)
        
        tableviewFlights.rowHeight = UITableViewAutomaticDimension
        tableviewFlights.estimatedRowHeight = 100
        
        tableviewFlights.rx.setDelegate(self).addDisposableTo(disposeBag)
        
        // data initializer
        viewModelFlight.initializeFlightData()
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
 
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FlightVC {
    fileprivate func updateCell(cell:FlightCell , row:Int , flightModel:Flight) {
        cell.lblOrigin.text = "Aybek Can Kaya"
        if row == 14 {
            cell.updateUI(with: flightModel, state: .expanded)
        }
        else {
            cell.updateUI(with: flightModel, state: .collapsed)
        }
        
    }
}



