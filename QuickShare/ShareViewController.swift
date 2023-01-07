//
//  ShareViewController.swift
//  QuickShare
//
//  Created by Reva Tamaskar on 03/01/23.
//

import UIKit
import Photos

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate {
    
    let tableView = UITableView()
    let imageView = UIImageView()
    let apps = ["Facebook","Instagram","Messenger","Pinterest","Twitter","WhatsApp"]
    
    var asset: PHAsset?
    var documentInteractionController = UIDocumentInteractionController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 300, height: 250), contentMode: .aspectFit, options: nil, resultHandler: {(result, info) in
            if let image = result {
                self.imageView.image = image
            }
        })
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300),
            imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
        
        
        imageView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 375)
        ])
        
        //self.view.backgroundColor = UIColor(red: 0.85, green: 0.07, blue: 0.35, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(apps[indexPath.row])"
        content.image = UIImage(named: "\(apps[indexPath.row])")
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if apps[indexPath.row] == "Instagram"{
        
            let url = URL(string: "instagram://library?LocalIdentifier=\(asset!.localIdentifier)")!

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Instagram is not installed", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
        if apps[indexPath.row] == "WhatsApp"{
        
        let urlWhats = "whatsapp://app"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {

                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    
                    var myImage: UIImage?
                    
                    PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 300, height: 250), contentMode: .aspectFit, options: nil, resultHandler: {(result, info) in
                        if let picture = result {
                            myImage = picture
                        }
                    })
                    if let image = myImage {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                            do {
                                try imageData.write(to: tempFile, options: .atomic)
                                self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                                self.documentInteractionController.uti = "net.whatsapp.image"
                                self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)

                            } catch {
                                print(error)
                            }
                        }
                    }

                }
                else {
                    let alertController = UIAlertController(title: "Error", message: "WhatsApp is not installed", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
            
        }

    }
    
}
