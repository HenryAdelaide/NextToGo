//
//  RaceTableViewCell.swift
//  NextToGo
//
//  Created by Henry Liu on 2/11/2024.
//

import UIKit

class RaceTableViewCell: UITableViewCell {
    
    /// Label to display Meeting Time
    @IBOutlet weak var meetingNameLabel: UILabel!
    /// Label to display Advertised Start
    @IBOutlet weak var advertisedStartLabel: UILabel!
    /// Label to display Race Number
    @IBOutlet weak var raceNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with race: RaceSummary) {
        meetingNameLabel.text = race.meetingName
        advertisedStartLabel.text = DateFormatter().formattedString(timestamp: race.advertisedStart.seconds)
        raceNumberLabel.text = "\(race.raceNumber)"
    }
}
