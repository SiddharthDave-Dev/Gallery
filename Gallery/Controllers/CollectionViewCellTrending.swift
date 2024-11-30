//
//  CollectionViewCellTrending.swift
//  Gallery
//
//  Created by Siddharth Dave on 28/09/23.
//

import UIKit

class CollectionViewCellTrending: UICollectionViewCell {
    
   
    @IBOutlet weak var colorBtnCell: UIButton!

    
    var didSelect: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.colorBtnCell.layer.cornerRadius = 50
    }
    
    
    
    @IBAction func colorBtnTapped(_ sender: Any) {
        didSelect?()
    }
    
    
    
    
}
