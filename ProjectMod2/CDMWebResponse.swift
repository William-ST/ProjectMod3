//
//  CDMWebResponse.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class CDMWebResponse: NSObject {
    
    var respuestaJSON   : Any?
    var statusCode      : NSInteger?
    var respuestaNSData : Data?
    var error           : Error?
    var datosCabecera   : NSDictionary?
}

