//
//  ViewController.swift
//  TableView
//
//  Created by mac on 6/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    var shoppingItems: [String] = ["Apples", "Bananas", "Oranges"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        
        let shoppingItem = shoppingItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = shoppingItem
        
        cell.contentConfiguration = content
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
}

