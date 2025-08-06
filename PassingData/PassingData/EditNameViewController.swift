//
//  EditNameViewController.swift
//  PassingData
//
//  Created by mac on 6/3/25.
//

import UIKit

class EditNameViewController: UIViewController {

    weak var delegate: ProfileDelegate?
    
    @IBOutlet weak var editNameTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var placerHolderText: String?
    var profileVC: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let placerHolderText = placerHolderText {
            editNameTextField.placeholder = placerHolderText
        }
    }
    
    @IBAction func submitButtonDidTouch(_ sender: Any) {
        guard let profileVC = profileVC, let name = editNameTextField.text  else {
            return
        }
        delegate?.update(name: name)  // 调用委托方法传递数据
        dismiss(animated: true)
    }
    
    

}
