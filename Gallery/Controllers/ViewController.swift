//
//  ViewController.swift
//  Gallery
//
//  Created by Siddharth Dave on 16/09/23.
//

import UIKit
import SDWebImage


class ViewController: UIViewController {
    
    
    var apidata : ApiModel?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCollection()
        self.getData()
    }
    
    private func getData() {
        
        ApiHelper.sharedInstances.fetchPhoto(searchText: "all") { [weak self] data in
            guard let self else {
                return
            }
            
            self.apidata = data
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    private func registerCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Image save error: \(error.localizedDescription)")
        } else {
            print("Image saved successfully!")
            // You can show a success message or perform any other action here
        }
    }
    
    func showDownloadSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Image downloaded successfully!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apidata?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let images = apidata?.results[indexPath.row].urls.regular
    
        cell.image.sd_setImage(with: URL(string: images ?? ""))
        
        cell.didSelectImage = { [weak self] in
            guard let self = self,
                  let indexPath = self.collectionView.indexPath(for: cell),
                  let imageUrlString = self.apidata?.results[indexPath.row].urls.regular,
                  let imageUrl = URL(string: imageUrlString) else {
                return
            }
            
            // Use SDWebImage to download the image asynchronously
            SDWebImageDownloader.shared.downloadImage(with: imageUrl, options: [], progress: nil) { (downloadedImage: UIImage?, _, error, _) in
                if let error = error {
                    print("Image download error: \(error.localizedDescription)")
                } else if let downloadedImage = downloadedImage {
                    // Save the downloaded image to the photo library
                    cell.saveImageToGallery(image: downloadedImage)
                    self.showDownloadSuccessAlert()
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 50 ) / 2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let vc = storyboard?.instantiateViewController(identifier: "setImage") as? SetImageViewController else {
            return
        }
        
        let image = apidata?.results[indexPath.row].urls.regular
        vc.waallImage = image ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Handle empty search text, e.g., reset the data
            apidata = nil
            collectionView.reloadData()
            ApiHelper.sharedInstances.fetchPhoto(searchText: "all") { [weak self] api in
                        guard let self = self else { return }
                        self.apidata = api
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
        } else {
            // Perform a search with non-empty text
            ApiHelper.sharedInstances.fetchPhoto(searchText: searchText) { [weak self] api in
                guard let self = self else { return }
                self.apidata = api
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.collectionView.reloadData()
                })
                
            }
        }
    }
}
