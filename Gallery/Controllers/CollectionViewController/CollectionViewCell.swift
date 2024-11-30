//
//  CollectionViewCell.swift
//  Gallery
//
//  Created by Siddharth Dave on 16/09/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    let setWallpaper = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        createButton()
    }

    func createButton() {
        
        setWallpaper.frame = CGRect.init(x: self.frame.width/16.5, y: self.frame.height/1.5, width: 150, height: 35)
        
        setWallpaper.setTitle("Download Image", for: .normal)
        
        setWallpaper.setTitleColor(.black, for: .normal)
        
        setWallpaper.backgroundColor = .green.withAlphaComponent(0.5)
        
        setWallpaper.layer.cornerRadius = 18
        
        setWallpaper.layer.borderColor = UIColor.black.cgColor
        
        setWallpaper.layer.borderWidth = 1.0
        
        addSubview(setWallpaper)
        
        setWallpaper.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    var didSelectImage: (()->Void)?
    
    @objc func pressed() {
        didSelectImage?()
    }
    
    func saveImageToGallery(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                print("Image save error: \(error.localizedDescription)")
            } else {
                print("Image saved successfully to the photo library!")
            }
        }
    
    
    
    
}
