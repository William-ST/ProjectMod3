//
//  ShoppingCarViewController.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 24/03/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class ShoppingCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewShoppingCar: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableViewShoppingCar.delegate = self
        tableViewShoppingCar.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItem", for: indexPath) as! ShoppingCarViewCellTableViewCell
        
        let product = shoppingCar[indexPath.row]
        
        cell.imageViewScreen.image = product.image
        cell.lblName.text = product.name
        if product.count != nil {
            cell.steeperCount.value = Double(product.count)
            cell.lblAmount.text = String(product.amount * Double(product.count))
        } else {
            cell.lblAmount.text = String(product.amount)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("shoppingCar.count: \(shoppingCar.count)")
        return shoppingCar.count
    }

}
