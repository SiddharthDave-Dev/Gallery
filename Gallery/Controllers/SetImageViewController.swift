//
//  SetImageViewController.swift
//  Gallery
//
//  Created by Siddharth Dave on 16/09/23.
//

import UIKit
import SDWebImage
import Toast_Swift

class SetImageViewController: UIViewController {
    
    @IBOutlet weak var wallpaperImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIImageView!
    
    var like =  true
    
    var style = ToastStyle()
    
    var waallImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wallpaperImage.sd_setImage(with: URL(string: waallImage))
        checkAndUpdateLikeStatus()
    }
    
    func saveImageToGallery(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func checkAndUpdateLikeStatus() {
        if let liked = UserDefaults.standard.value(forKey: "Liked\(waallImage)") as? Bool {
            like = liked
            updateLikeButtonUI()
        }
    }
    
    func updateLikeButtonUI() {
        if like {
            likeButton.image = UIImage(named: "love.png")
            
        } else {
            likeButton.image = UIImage(named: "heart.png")
            
        }
    }
    
    func showDownloadSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Image downloaded successfully!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Image save error: \(error.localizedDescription)")
        } else {
            print("Image saved successfully to the photo library!")
        }
    }
    
    @IBAction func downloadImage(_ sender: Any) {
        guard let imageUrl = URL(string: waallImage) else {
                return
            }
            
            SDWebImageDownloader.shared.downloadImage(with: imageUrl, options: [], progress: nil) { (downloadedImage: UIImage?, _, error, _) in
                if let error = error {
                    print("Image download error: \(error.localizedDescription)")
                } else if let downloadedImage = downloadedImage {
                    // Save the downloaded image to the photo library
                    self.saveImageToGallery(image: downloadedImage)
                    
                    // Show an alert when the image is downloaded successfully
                    self.showDownloadSuccessAlert()
                }
            }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        
        like.toggle()
        updateLikeButtonUI()
        
        if !like {
            style.messageColor = .white
            
            self.view.makeToast("The Message was liked", duration: 2.0, position: .center, style: style)
            
            ToastManager.shared.style = style
    
            ToastManager.shared.isTapToDismissEnabled = true
            
            ToastManager.shared.isQueueEnabled = true
        }
        else {
            style.messageColor = .white
            
            self.view.makeToast("The Message was unliked", duration: 2.0, position: .center, style: style)
            
            ToastManager.shared.style = style
            
            ToastManager.shared.isTapToDismissEnabled = true
            
            ToastManager.shared.isQueueEnabled = true
        }
        
        UserDefaults.standard.set(like, forKey: "Liked\(waallImage)")
    }
}
