//
//  ShoppingCarViewController.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 24/03/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit
import CoreLocation

class ShoppingCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    
    
    @IBOutlet weak var tableViewShoppingCar: UITableView!

    @IBOutlet weak var buttonBuy: UIButton!
    
    let manager = CLLocationManager()
    var currentLatitude = ""
    var currentLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.distanceFilter = 10
        

        
        
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            manager.requestAlwaysAuthorization()
        }
        
        
        
        tableViewShoppingCar.delegate = self
        tableViewShoppingCar.dataSource = self
        
        tableViewShoppingCar.sectionHeaderHeight = 0;
        if shoppingCar.count > 0 {
            buttonBuy.isHidden = false;
        } else {
            buttonBuy.isHidden = true;
        }
        buttonBuy.isEnabled = false;
    }
    
    

    @IBAction func actionBuyTouchUp(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Mensaje", message: "¿Desea realizar la compra?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "SI", style: UIAlertActionStyle.default, handler: { (action) in
            
            
            let requestBuyBody = RequestBuyBody()
            requestBuyBody.usuarioId = userEntityValidate.userId
            requestBuyBody.latitude = "\(self.currentLatitude)"
            requestBuyBody.longitude = "\(self.currentLongitude)"
            print("shoppingCar.count() \(shoppingCar.count)")
            
            requestBuyBody.products = shoppingCar.description
            print("---> ")
            print(requestBuyBody.products)
            
            print(requestBuyBody)
            CDMWebModel.saleProducts(requestBuyBody, conCompletionCorrecto: { (status) in
                if (status) {
                    let alertController = UIAlertController(title: "Consorciohbo", message: "Venta realizada", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "GRACIAS", style: UIAlertActionStyle.default)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: { 
                        self.navigationController?.popViewController(animated: true)
                    })
                    shoppingCar = Array<Product>()
                    self.tableViewShoppingCar.reloadData()
                }
            }) { (message) in
                self.showError(message : message)
            }
        })
        let cancelAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: { (action) in
            
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: {})
        
        
        
        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLatitude = "\(locations[0].coordinate.latitude)"
        currentLongitude = "\(locations[0].coordinate.longitude)"
        buttonBuy.isEnabled = true;
        manager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItem", for: indexPath) as! ShoppingCarViewCellTableViewCell
        
        let product = shoppingCar[indexPath.row]
        
        let productImageUrl = product.image.count > 0 ? product.image[0] : ""
        
        if let checkedUrl = URL(string: productImageUrl) {
            cell.imageViewScreen.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, imageViewPhoto: cell.imageViewScreen)
        }
        
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
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return tableView.sectionHeaderHeight
    }
    
    func downloadImage(url: URL, imageViewPhoto: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                imageViewPhoto.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Consorciohbo", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

}
