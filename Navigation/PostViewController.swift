//
//  PostViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import UIKit
import StorageService


class PostViewController: UIViewController {
    public var myTitle: String?
    public var myMessage: String?
    private lazy var barButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapBarButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = titlePost
        self.view.backgroundColor = .lightGray
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    @objc func tapBarButton(){
        print("Инфо")
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .automatic
        infoVC.myTitle = myTitle
        infoVC.myMessage = myMessage
        self.present(infoVC, animated: true, completion: nil)
        
        
    }
    
    public func setupAlert(title: String, message: String, preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        print(alert)
        return alert
    }
}
