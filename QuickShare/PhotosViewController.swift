//
//  PhotosViewController.swift
//  QuickShare
//
//  Created by Reva Tamaskar on 03/01/23.
//

import UIKit
import Photos

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var assetCollection: PHAssetCollection?
    var photos: PHFetchResult<PHAsset>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        if (collection.firstObject != nil) {
            self.assetCollection = collection.firstObject! as PHAssetCollection
            
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            self.photos = PHAsset.fetchAssets(in: assetCollection!, options: options)
        }
        else {
            print("no photos")
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(123, 120)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        
        self.view.backgroundColor = UIColor(red: 0.85, green: 0.07, blue: 0.35, alpha: 1)    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let asset = self.photos?[indexPath.row] {
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 250), contentMode: .aspectFit, options: nil, resultHandler: {(result, info) in
                if let image = result {
                    let imageView = UIImageView()
                    imageView.image = image
                    cell.contentView.addSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor),
                        imageView.heightAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.heightAnchor),
                        imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                        imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
                    ])
                    print(image.size)
                }
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = ShareViewController()
        newVC.title = "Quick Share"
        newVC.asset = self.photos?[indexPath.row]
        let navVC = UINavigationController(rootViewController: newVC)
        navVC.modalPresentationStyle = .popover
        present(navVC, animated: true)
    }

}
