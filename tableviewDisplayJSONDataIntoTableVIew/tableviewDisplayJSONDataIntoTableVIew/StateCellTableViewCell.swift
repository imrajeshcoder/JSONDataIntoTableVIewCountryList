//
//  StateCellTableViewCell.swift
//  tableviewDisplayJSONDataIntoTableVIew
//
//  Created by Vijay on 05/02/21.
//

import UIKit

class StateCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStateNameDisplay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
