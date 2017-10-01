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
    
    fileprivate var currentState:CellState = CellState.collapsed
    
    var state:CellState {
        get {
            return currentState
        }
    }
    
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
        viewBottom.alpha = state == CellState.collapsed ? 0:1
        heightConstaintBottomView.constant = state == CellState.collapsed ? 0:160
        updateUpperView(model: model)
        if state == CellState.expanded { updateBottomView(model: model) }
        layoutIfNeeded()
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
        
        lblDurationBottom.text = model.durationFlight
        lblTicketClass.text = "Bilet sınıfı: "+model.ticketClass
      
        guard let airline = model.airlineFlight else {
            lblAirlineNameBottom.text = "-"
            lblFlightIdentifier.text = "-"
            return
        }
        
        lblAirlineNameBottom.text = airline.name
        lblFlightIdentifier.text = airline.code
        
        guard let airportOrigin = model.airportOrigin , let airportDestination = model.airportDestination else {
            lblOrigin.text = "-"
            lblDestination.text = "-"
            return
        }
        
        lblOrigin.text = model.timeDeparture+", "+airportOrigin.airportName
        lblDestination.text = model.timeArrival+", "+airportDestination.airportName
    
        guard let attributes = model.flightAttributes else {
            lblAttributesText.text = ""
            return
        }
        
        lblAttributesText.text = attributes.stringify()
        //lblAttributesText.numberOfLines = 0
        //lblAttributesText.sizeToFit()
    }
    
    func toggleCellState() {
        currentState == .collapsed ? expandCell() : collapseCell()
    }
    
    private func collapseCell() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            self.heightConstaintBottomView.constant = 0
            self.viewBottom.alpha = 0
        }) { finished in
            self.currentState = .collapsed
        }
    }
    
    private func expandCell() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                self.heightConstaintBottomView.constant = 160
                self.viewBottom.alpha = 1
                self.layoutIfNeeded()
        }) { finished in
            self.currentState = .expanded
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
