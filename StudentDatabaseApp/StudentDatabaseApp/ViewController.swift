//
//  ViewController.swift
//  StudentDatabaseApp
//
//  Created by mac on 5/23/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var studentNamesLabel: UILabel!
    
    @IBOutlet weak var studentNameTextField: UITextField!
    
    @IBOutlet weak var searchNameLabel: UILabel!
    
    @IBOutlet weak var searchNameTextField: UITextField!
    
    var students: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        studentNamesLabel.text = ""
        studentNamesLabel.frame = CGRect(x: 20, y: 70, width: view.frame.width - 40, height: studentNamesLabel.frame.height * 3)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let studentName = studentNameTextField.text, !studentName.isEmpty,
            studentName.count >= 3 else {
            return
        }
        
        students.append(studentName)
        var interimStudents = ""
        for student in students {
            interimStudents += " \(student)"
        }
        studentNamesLabel.text = interimStudents
        studentNameTextField.text = nil
        print(students.count)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        guard let searchStudentName = searchNameTextField.text, !searchStudentName.isEmpty,
              searchStudentName.count >= 3 else {
            return
        }
        
        if students.contains(searchStudentName) {
            searchNameLabel.text = "\(searchStudentName) is existed"
        } else {
            searchNameLabel.text = "\(searchStudentName) is not existed"
        }
        
    }
}

