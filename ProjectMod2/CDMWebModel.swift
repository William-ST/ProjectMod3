//
//  CDMWebModel.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class CDMWebModel: NSObject {
    
    typealias Signin = (_ user : NSObject) -> Void
    typealias GetSalesPoint = (_ arraySalePoint: Array<SalePointEntity>) -> Void
    typealias GetProducts = (_ arrayProducts: Array<ProductEntity>) -> Void
    typealias SaleProducts = (_ response : Bool) -> Void
    
    typealias MensajeErrorStatus = (_ mensajeError : String) -> Void
    static let CDMWebModelURLBase : NSString = "https://mobile.consorciohbo.com.pe/testservice/TestService.svc/"
    
    class func saleProducts(_ requestBuyBody : RequestBuyBody, conCompletionCorrecto completionCorrecto : @escaping SaleProducts, error procesoIncorrecto : @escaping MensajeErrorStatus) {
        let dic : [NSString : Any] = ["UsuarioID" : requestBuyBody.usuarioId,
                                      "Latitud": requestBuyBody.latitude,
                                      "Longitud": requestBuyBody.longitude,
                                      "Productos": requestBuyBody.products]
        
        let path = "RegistrarPedido"
        
        CDMWebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: path as NSString, conParametros: dic) { (objRespuesta) in
            let respuesta = objRespuesta.respuestaJSON as? NSDictionary
            let mensajeError = "Ha ocurrido un error!"
            if objRespuesta.statusCode! < 200 || objRespuesta.statusCode! > 299 {
                procesoIncorrecto(mensajeError)
            } else if respuesta != nil {
                completionCorrecto(true)
            } else {
                procesoIncorrecto(mensajeError)
            }
            
        }
    }
    
    class func signinCustomer(_ signinBody : SigninBody, conCompletionCorrecto completionCorrecto : @escaping Signin, error procesoIncorrecto : @escaping MensajeErrorStatus) {
        let dic : [NSString : Any] = ["Usuario" : signinBody.username,
                                      "Password" : signinBody.password]
        
        let path = "Autenticar"
        
        CDMWebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: path as NSString, conParametros: dic) { (
            objRespuesta) in
            let userRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let mensajeError = "Ha ocurrido un error!"
            if objRespuesta.statusCode! < 200 || objRespuesta.statusCode! > 299 {
                procesoIncorrecto(mensajeError)
            } else if userRespuesta != nil {
                completionCorrecto(CDMWebTranslator.translateUserEntity(userRespuesta!))
            } else {
                procesoIncorrecto(mensajeError)
            }
        }
    }
    
    class func getSalesPoint(conCompletionCorrecto completionCorrecto : @escaping GetSalesPoint, error procesoIncorrecto : @escaping MensajeErrorStatus) {
    
        let path = "ListarPuntosVenta"
        
        CDMWebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: path as NSString, conParametros: nil) { (objRespuesta) in
            let arrayRespuesta = objRespuesta.respuestaJSON as? NSArray
            
            let mensajeError = "Ha ocurrido un error!"
            if arrayRespuesta != nil {
                var arrayFinal = Array<SalePointEntity>()
                arrayRespuesta?.enumerateObjects({ (obj, idx, stop) in
                    arrayFinal.append(CDMWebTranslator.translateSalePointEntity(obj as! NSDictionary))
                })
                completionCorrecto(arrayFinal)
            } else {
                procesoIncorrecto(mensajeError)
            }
        }
    }
    
    class func getListProducts(conCompletionCorrecto completionCorrecto : @escaping GetProducts, error procesoIncorrecto : @escaping MensajeErrorStatus) {
    
        let path = "ListarProductos"
        
        CDMWebSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: path as NSString, conParametros: nil) { (objRespuesta) in
            let arrayRespuesta = objRespuesta.respuestaJSON as? NSArray
            print("\(arrayRespuesta)")
            let mensajeError = "Ha ocurrido un error!"
            if arrayRespuesta != nil {
                var arrayFinal = Array<ProductEntity>()
                arrayRespuesta?.enumerateObjects({ (obj, idx, stop) in
                    arrayFinal.append(CDMWebTranslator.translateProductEntity(obj as! NSDictionary))
                })
                print("------>")
                print("\(arrayFinal[0])")
                completionCorrecto(arrayFinal)
            } else {
                procesoIncorrecto(mensajeError)
            }
            
            
            
        }
        
    }

}
