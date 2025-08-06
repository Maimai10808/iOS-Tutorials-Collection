//
//  ShoppingItemDetailViewController.swift
//  TableViewController
//
//  Created by mac on 6/7/25.
//

import UIKit

class ShoppingItemDetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    var shoppingItem: ShoppingItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let shoppingItem = shoppingItem {
            detailLabel.text = shoppingItem.subTitle
        }
    }
    
    

    

}
