//
//  WaifuViewModel.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 06/06/22.
//

import Foundation


class WaifuViewModel{
    
    
    
    static func getWaifus(type:IMAGE_TYPE,category:IMAGE_CATEGORIES,limit:Int,result:@escaping ([WaifuInterable]) -> Void){
        
        var haren:[WaifuInterable] = []
        
        for i in 1...limit{
            
            ApiService.getRandomImage(type: type, category: category) { waifu in
               
                let newWaifu = WaifuInterable.init(id: i, url: waifu.url)
                haren.append(newWaifu)
                
                result(haren)
                
            } onFailure: { err in
                print(err)
            }
            
        }

    }
    
}
