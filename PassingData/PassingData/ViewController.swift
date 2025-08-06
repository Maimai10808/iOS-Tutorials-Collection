//
//  ViewController.swift
//  PassingData
//
//  Created by mac on 6/3/25.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func update(name: String)
}

let updateBioNotification = Notification.Name("com.fullstacktuts.updatedBioKey")

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    var currentName = "Maiyufan"
    var currentBio = "My first bio"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBio(_:)),
            name: updateBioNotification,
            object: nil)
    }
    
    @objc func  updateBio(_ notification: Notification) {
        if let userInfo = notification.userInfo, let bio = userInfo["bio"]  as? String {
            currentBio = bio
            bioLabel.text = bio
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNameSegue" {
            let destinationVC =  segue.destination as! EditNameViewController
            destinationVC.placerHolderText = currentName
            destinationVC.delegate = self  // 传递委托
        }
    }
    
    
    
    @IBAction func editNameButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "editNameSegue", sender: nil)
    }
    
    @IBAction func eidtBioBUttonDidTouch(_ sender: Any) {
       let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editBioVC = mainStoryboard.instantiateViewController(withIdentifier: "EditBioVC") as! EditBioViewController
        editBioVC.placeholderText = currentBio
        present(editBioVC, animated: true)
    }
    
}

extension ViewController: ProfileDelegate {
    func update(name: String) {
        nameLabel.text = name
        currentName = name
    }
}

