//
//  EditBioViewController.swift
//  PassingData
//
//  Created by mac on 6/3/25.
//

import UIKit

class EditBioViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var bioTextView: UITextField!
    
    var placeholderText = "Placeholder"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bioTextView.layer.borderWidth = 0.5
        bioTextView.layer.borderColor = UIColor.lightGray.cgColor
        bioTextView.text = placeholderText

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonDidtouch(_ sender: Any) {
        guard let bio = bioTextView.text else {
            return
        }
        
        let userInfo: [String: Any] = ["bio": bio]
        NotificationCenter.default.post(
            name: updateBioNotification,
            object: nil,
            userInfo: userInfo)
        
        dismiss(animated: true)
    }
    
}

extension EditBioViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.textColor = UIColor.lightGray
            textView.text = placeholderText
        }
    }
    
}
