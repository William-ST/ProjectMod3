//
//  CDMWebSender.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class CDMWebSender: NSObject {
    
    class func crearCabeceraPeticion() -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        
        return diccionarioHeader
    }
    
    class func obtenerRespuestaEnJSONConData(_ data : Data) -> Any? {
        
        do{
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
        }catch{
            return nil
        }
    }
    
    class func obtenerRespuestaServicio(paraData data : Data?, conResponse response : URLResponse?, conError error : NSError?) -> CDMWebResponse{
        
        var respuesta : Any? = nil
        
        if error == nil && data != nil {
            respuesta = self.obtenerRespuestaEnJSONConData(data!)
        }
        
        let urlResponse = response as? HTTPURLResponse
        
        let headerFields : NSDictionary? = urlResponse?.allHeaderFields as NSDictionary?
        let objRespuesta = CDMWebResponse()
        
        objRespuesta.respuestaJSON      = respuesta
        objRespuesta.statusCode         = urlResponse?.statusCode
        objRespuesta.respuestaNSData    = data
        objRespuesta.error              = error
        objRespuesta.datosCabecera      = headerFields
        
        return objRespuesta
    }
    
    @discardableResult class func doPOSTToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : Any?, conCompletion completion : @escaping (_ objRespuesta : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    @discardableResult class func doPUTToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : Any?, conCompletion completion : @escaping (_ objRespuesta : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    @discardableResult class func doGETToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : Any?, conCompletion completion : @escaping (_ objRespuesta : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objRespuesta = self.obtenerRespuestaServicio(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
}
