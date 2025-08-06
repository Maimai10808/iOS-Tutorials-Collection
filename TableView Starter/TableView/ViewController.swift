//
//  ViewController.swift
//  TableView
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var users: [UserModel] = [
        UserModel(avatar: UIImage(systemName: "person")!, name: "James Gosling", bio: "iOS Dev"),
        UserModel(avatar: UIImage(systemName: "person")!, name: "Dennis Ritchie", bio: "Web Dev"),
        UserModel(avatar: UIImage(systemName: "person")!, name: "Alan Turing", bio: "backend Dev")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        let nib = UINib(nibName: "UserXibTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: UserXibTableViewCell.idntifier)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

}

//MARK: - Tableview Datasource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserXibTableViewCell.idntifier, for: indexPath) as! UserXibTableViewCell
        
        cell.configure(user: user)
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


