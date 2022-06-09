//
//  WaifuViewModel.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 06/06/22.
//

import Foundation


class WaifuViewModel{
    
    
    static func getManyWaifusFsw(category:IMAGE_CATEGORIES_FSW,limit:Int,result:@escaping ([WaifuInterable]) -> Void,onFailure:@escaping (ErrorHandler) -> Void){
        var haren:[WaifuInterable] = []
        
        for i in 1...limit{
            
            ApiService.getRandomImageFsw(category: category) { waifu in
                
                 let newWaifu = WaifuInterable.init(id: i, url: waifu.url)
                 haren.append(newWaifu)
                 
                 result(haren)
            } onFailure: { err in
                
              
                
            }

            
        }
    }
    
    static func getManyWaifusNfsw(category:IMAGE_CATEGORIES_NSFW,limit:Int,result:@escaping ([WaifuInterable]) -> Void){
        var haren:[WaifuInterable] = []
        
        for i in 1...limit{
            
            ApiService.getRandomImageNfsw(category: category) { waifu in
                
                 let newWaifu = WaifuInterable.init(id: i, url: waifu.url)
                 haren.append(newWaifu)
                 
                 result(haren)
            } onFailure: { err in
                print(err)
            }

            
        }
    }
    
}
