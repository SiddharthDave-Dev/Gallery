//
//  TableViewCell.swift
//  Gallery
//
//  Created by Siddharth Dave on 27/09/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var btnCategories: UIButton!
    @IBOutlet weak var imageCategories: UIImageView!
    
    var didSelectCategories: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnCategoriesTapped(_ sender: Any) {
        didSelectCategories?()
    }
    
}
