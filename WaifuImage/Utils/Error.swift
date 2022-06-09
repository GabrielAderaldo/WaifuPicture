//
//  ErrorFile.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 08/06/22.
//

import Foundation

class ErrorHandler{
    
    let errorCode:Int
    let descriptionError:String
    let nameError:String
    let dataError:Any?
    
    init(errorCode:Int,descriptionError:String,nameError:String,dataError:Any?){
        self.errorCode = errorCode
        self.descriptionError = descriptionError
        self.nameError = nameError
        self.dataError = dataError
    }
    
}
