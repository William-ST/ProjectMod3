//
//  ProductListViewController.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 20/03/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

var shoppingCar = Array<Product>()

class ProductCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productCollection = Array<Product>()
    var productFilterCollection = Array<Product>()
    var selectProduct = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        var names = Array<String>()
        names.append("Samsung 5")
        names.append("iPhone 5C")
        names.append("iPhone 6")
        names.append("iPhone 6S")
        names.append("iPhone 7")
        names.append("iPhone 7S")
        names.append("Tablet XP")
        names.append("Laptop Pavilion")
        names.append("Mackbook Pro")
        names.append("Mackbook Pro Retina")
        names.append("iPod 3")
        names.append("iPod 5")
        
        for i in 0..<12 {
            let product = Product()
            print("i: \(i)")
            product.id = i+1
            product.name = names[i]
            product.amount = 20.00 * Double(i)
            product.image = UIImage(named: "iphone\(i)")
            product.detail = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ut elit ac risus vulputate tincidunt. Nam accumsan, augue quis auctor consectetur, metus magna consectetur lectus, nec auctor arcu orci vitae arcu. Morbi at fringilla eros. In sollicitudin eros ut dui venenatis iaculis. In eu augue est. Ut in efficitur orci. Suspendisse potenti. Cras ac eros id eros dignissim posuere."
            productCollection.append(product)
        }
        
    }
    
    func itemLongSelected(sender:UILongPressGestureRecognizer) {
        
        if (sender.state == UIGestureRecognizerState.ended) {
        
        
        print("row: \(sender.view!.tag)")
        
        var product = Product()
        if searchBar.text != nil && !searchBar.text!.isEmpty {
            product = productFilterCollection[sender.view!.tag]
        } else {
            product = productCollection[sender.view!.tag]
        }
        
        
        print("itemLongSelected")
        print("id: \(product.id)");
        print("name: \(product.name!)");
        
        let alertController = UIAlertController(title: product.name, message: "¿Desea agregar el producto al carrito?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            for i in 0..<shoppingCar.count {
                if (shoppingCar[i].id == product.id) {
                    shoppingCar.insert(product, at: i)
                    return
                }
            }
            shoppingCar.append(product)
        })
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: { (action) in
            print("CANCEL pressed!!")
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: {})
        }
    }
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
            print("handleLongPress long pressed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("productCollection.count: \(productCollection.count)")
        if searchBar.text != nil && !searchBar.text!.isEmpty {
            return productFilterCollection.count
        } else {
            return productCollection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
        let product:Product
        
        if searchBar.text != nil && !searchBar.text!.isEmpty {
            product = productFilterCollection[indexPath.row]
            print("filter")
        } else {
            product = productCollection[indexPath.row]
            print("empty")
        }
        
        print("-- name: \(product.name)")
        print("-- indexPath.row: \(indexPath.row)")
        
        cell.labelName.text = product.name
        cell.labelAmount.text = "S/. \(product.amount!)"
        cell.imageProduct.image = product.image
        
        cell.tag = indexPath.row
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(itemLongSelected))
        
        longPressGestureRecognizer.minimumPressDuration = 0.5//seg
        longPressGestureRecognizer.delaysTouchesBegan = true
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchBar.text != nil && !searchBar.text!.isEmpty {
            selectProduct = productFilterCollection[indexPath.row]
        } else {
            selectProduct = productCollection[indexPath.row]
        }
        self.performSegue(withIdentifier: "productDetailLink", sender: self)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange: \(searchText)")
        
        productFilterCollection = productCollection.filter({ (product) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased()) ||
                String(product.amount).contains(searchText)
        })
        collectionView.reloadData()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "productDetailLink") {
            let productDetailViewController = segue.destination as! ProductDetailViewController
            productDetailViewController.currentProduct = selectProduct
        }
    }
    
}
