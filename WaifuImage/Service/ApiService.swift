//
//  ApiService.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 06/06/22.
//

import Foundation
import UIKit


class ApiService{
    
    private func genereteImgURL(type:IMAGE_TYPE,category:IMAGE_CATEGORIES) -> String{
        
        var typeString:String = ""
        var categoryString:String = ""
        
        switch type {
        case .fsw:
            typeString = "sfw"
        case .nfsw:
            typeString = "nsfw"
        }
        
        switch category {
        case .waifu:
            categoryString = "waifu"
        case .neko:
            categoryString = "neko"
        case .bully:
            categoryString = "bully"
        }
        
        return "\(typeString)/\(categoryString)"
    }
    
    static func getRandomImage(type:IMAGE_TYPE,category:IMAGE_CATEGORIES,onSucess:@escaping(Waifu) -> Void,onFailure:@escaping (Any) -> ()){
        
        let baseUrl = "https://api.waifu.pics/"
        let complement = ApiService().genereteImgURL(type: type, category: category)
        let url = "\(baseUrl)\(complement)"
        
        URLSession.httpGet(url: url, paramets: nil, typeReturn: .data) { data in
            
            
            guard let data = data as? Data else{ return }
           
            
                do{
                    let imgDecode = try JSONDecoder().decode(Waifu.self, from: data)
                    onSucess(imgDecode)
                    
                }catch let err{
                    onFailure(err)
                }
            
            
        } failure: { err in
            onFailure(err)
        }

        
    }
    
    
}
