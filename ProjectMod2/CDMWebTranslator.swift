//
//  CDMWebTranslator.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class CDMWebTranslator: NSObject {
    
    class func translateUserEntity(_ objDic : NSDictionary) -> UserEntity {
        
        let objBE = UserEntity()
        objBE.userId = objDic["UsuarioID"] as? String
        objBE.fullname = objDic["NombreCompleto"] as? String
        return objBE
    }
    
    class func translateSalePointEntity(_ objDic : NSDictionary) -> SalePointEntity {
    
        let obj = SalePointEntity()
        obj.name = objDic["Nombre"] as? String
        obj.address = objDic["Direccion"] as? String
        obj.latitude = objDic["Latitud"] as? String
        obj.longitude = objDic["Longitud"] as? String
        return obj
    }
    
    class func translateProductEntity(_ objDic : NSDictionary) -> ProductEntity {
        print(objDic)
        let obj = ProductEntity()
        obj.idProduct = "\(objDic["ProductoID"] as? Int)"
        obj.name = objDic["Nombre"] as? String
        obj.descriptionProduct = objDic["Descripcion"] as? String
        obj.price = objDic["Precio"] as? Double
        
        obj.listImages = objDic["lstImagenes"] as? Array<String>
        
        return obj
    }
    
}
