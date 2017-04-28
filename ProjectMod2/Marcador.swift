//
//  Marcador.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit
import MapKit

class Marcador: NSObject, MKAnnotation {
    
    var nombre:String?
    var descriptionSelf: String?
    var coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.nombre = title
        self.descriptionSelf = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    var title:String? {
        return nombre
    }
    
    var subtitle:String? {
        return descriptionSelf
    }
    
}
