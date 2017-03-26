//
//  ProductDetailViewController.swift
//  ProjectMod2
//
//  Created by Alumno on 21/03/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblNAme: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblAount: UILabel!
    
    var currentProduct = Product()
    
    
    @IBAction func actionBuy(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = "Tienda Virtual"
        
        print("Precio: \(currentProduct.amount)")
        imageView.image = currentProduct.image
        lblNAme.text = currentProduct.name
        lblAount.text = "S/. \(currentProduct.amount!)"
        lblDescription.text = currentProduct.detail
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItemTouchUp(_ sender: Any) {
        
        for i in 0..<shoppingCar.count {
            print("\(shoppingCar[i].id!) == \(currentProduct.id!)")
            if (shoppingCar[i].id! == currentProduct.id!) {
                shoppingCar[i] = currentProduct
                showAddedProduct()
                return
            }
        }
        shoppingCar.append(currentProduct)
        showAddedProduct()
        
    }
    
    func showAddedProduct() {
        let alertController = UIAlertController(title: currentProduct.name, message: "Producto agregado al carrito!", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            print("OK pressed!!")
        })
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: {})
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
