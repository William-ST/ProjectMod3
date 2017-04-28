//
//  MapperProductEntity.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class MapperProductEntity: NSObject {

    class func transform(productEntity : ProductEntity) -> Product {
        let product = Product()
        print("productEntity.idProduct: \(productEntity.idProduct)")
        product.id = productEntity.idProduct
        print("product.id: \(product.id)")
        product.name = productEntity.name
        product.detail = productEntity.descriptionProduct
        product.amount = productEntity.price
        product.image = productEntity.listImages
        return product
    }
    
    class func transform(productEntityList : Array<ProductEntity>) -> Array<Product> {
        var listProduct = Array<Product>()
        for productEntity in productEntityList {
            listProduct.append(transform(productEntity: productEntity))
        }
        return listProduct;
    }
    
}
