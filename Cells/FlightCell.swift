//
//  FlightCell.swift
//  FlightTicket
//
//  Created by aybek can kaya on 01/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import UIKit
import Kingfisher

enum CellState {
    case collapsed
    case expanded
}

class FlightCell: UITableViewCell {

    @IBOutlet weak var heightConstaintBottomView: NSLayoutConstraint!
    @IBOutlet weak var imViewAirlineIcon: UIImageView!
    @IBOutlet weak var lblAirlineName: UILabel!
    @IBOutlet weak var lblAirportOriginDestination: UILabel!
    @IBOutlet weak var lblTimeArrival: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblBaggageInfo: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPromotionText: UILabel!
    @IBOutlet weak var lblAirlineNameBottom: UILabel!
    @IBOutlet weak var lblFlightIdentifier: UILabel!
    @IBOutlet weak var lblDurationBottom: UILabel!
    @IBOutlet weak var lblTicketClass: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblAttributesText: UILabel!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var btnChoose: UIButton!
    
    var currentState:CellState = CellState.collapsed
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnChoose.layer.cornerRadius = 4
        btnChoose.layer.borderColor = UIColor.navBarColor().cgColor
        btnChoose.layer.borderWidth = 1
        btnChoose.layer.masksToBounds = true 
        
    }
    
    func updateUI(with model:Flight , state:CellState) {
        currentState = state
        viewBottom.isHidden = state == CellState.collapsed
        heightConstaintBottomView.constant = state == CellState.collapsed ? 0:123
        updateUpperView(model: model)
        if state == CellState.expanded { updateBottomView(model: model) }
    }
    
    private func updateUpperView(model:Flight) {
        
        lblTimeArrival.text = model.timeArrival
        lblPrice.text = model.priceString
        lblDuration.text = model.durationFlight
        lblPromotionText.isHidden = !model.isPromo
       
        
        guard let airline = model.airlineFlight ,  let imageURL = URL(string:airline.imagePath) else {
            lblAirlineName.text = "-"
            return
        }
        lblAirlineName.text = airline.name
        imViewAirlineIcon.kf.setImage(with: imageURL)
        
        guard let airportOrigin = model.airportOrigin , let airportDestination = model.airportDestination else {
            lblAirportOriginDestination.text = "-"
            return
        }
        lblAirportOriginDestination.text = airportOrigin.airportCode+">"+airportDestination.airportCode
        
        guard let baggage = model.baggageFlight else {
            lblBaggageInfo.text = "-"
            return
        }
        lblBaggageInfo.text = String(describing:baggage.allowance)+" "+baggage.unit+"/kişi"
    }
    
    private func updateBottomView(model:Flight) {
        
        guard let airline = model.airlineFlight else {
            lblAirlineNameBottom.text = "-"
            lblFlightIdentifier.text = "-"
            return
        }
        lblAirlineNameBottom.text = airline.name
        lblFlightIdentifier.text = airline.code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
