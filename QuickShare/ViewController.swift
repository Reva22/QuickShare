//
//  ViewController.swift
//  QuickShare
//
//  Created by Reva Tamaskar on 02/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let quickShare = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.image = UIImage(named: "AppIcon-QuickShare")
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        //imageView.animationImages = [UIImage]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender: )))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
//        quickShare.text = "Quick Share"
//        quickShare.textColor = .white
//        quickShare.textAlignment = .center
//        quickShare.font = UIFont(name: "HelveticaNeue-Thin", size: 50)
//        self.view.addSubview(quickShare)
//        quickShare.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            quickShare.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            quickShare.heightAnchor.constraint(equalToConstant: 50),
//            quickShare.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            quickShare.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
//        ])
        
        self.view.backgroundColor = UIColor(red: 0.85, green: 0.07, blue: 0.35, alpha: 1)
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            let rootVC = PhotosViewController()
            rootVC.title = "Quick Share"
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
    }


}

