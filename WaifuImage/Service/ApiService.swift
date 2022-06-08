//
//  ApiService.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 06/06/22.
//

import Foundation
import UIKit


class ApiService{
    
    private func convertImage_CategoryToString(categoryFsw:IMAGE_CATEGORIES_FSW?,categoryNfsw:IMAGE_CATEGORIES_NSFW?) -> String{
        
        if let categoryFsw = categoryFsw {
            
            switch categoryFsw {
            case .bite:
                return "bite"
            case .blush:
                return "blush"
            case .bonk:
                return "bonk"
            case .bully:
                return "bully"
            case .cringe:
                return "cringe"
            case .cry:
                return "cry"
            case .cuddle:
                return "cuddle"
            case .dance:
                return "dance"
            case .glomp:
                return "glomp"
            case .handhold:
                return "handhold"
            case .happy:
                return "happy"
            case .highfive:
                return "highfive"
            case .hug:
                return "hug"
            case .kill:
                return "kill"
            case .kiss:
                return "kiss"
            case .lick:
                return "lick"
            case .megumin:
                return "megumin"
            case .neko:
                return "neko"
            case .nom:
                return "nom"
            case .pat:
                return "pat"
            case .poke:
                return "poke"
            case .shinobu:
                return "shinobu"
            case .slap:
                return "slap"
            case .smile:
                return "smile"
            case .smug:
                return "smug"
            case .waifu:
                return "waifu"
            case .wave:
                return "wave"
            case .wink:
                return "wink"
            case .yeet:
                return "yeet"
            }
            
        }
        
        if let categoryNfsw = categoryNfsw {
            switch categoryNfsw {
            case .waifu:
                return "waifu"
            case .neko:
                return "neko"
            case .trap:
                return "trap"
            case .blowjob:
                return "blowjob"
            }
        }
        
        return "the category are nil"
    }
    
    private func genereteImgURL(type:IMAGE_TYPE,categoryFws:IMAGE_CATEGORIES_FSW?,categoryNfws:IMAGE_CATEGORIES_NSFW?) -> String{
        switch type {
        case .fsw:
            
            guard let categoryFws = categoryFws else {
                return ""
            }
            
            return "sfw/\(convertImage_CategoryToString(categoryFsw: categoryFws, categoryNfsw: nil))"
            
        case .nfsw:
            guard let categoryNfws = categoryNfws else {
                return ""
            }
            
            return "nsfw/\(convertImage_CategoryToString(categoryFsw: nil, categoryNfsw: categoryNfws))"
        }
    }
    
    
    static func getRandomImageFsw(category:IMAGE_CATEGORIES_FSW,onSucess:@escaping(Waifu) -> Void,onFailure:@escaping (Any) -> ()){
        let baseUrl = "https://api.waifu.pics/"
        let complement = ApiService().genereteImgURL(type: .fsw, categoryFws: category, categoryNfws: nil)
        
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
    
    
    static func getRandomImageNfsw(category:IMAGE_CATEGORIES_NSFW,onSucess:@escaping(Waifu) -> Void,onFailure:@escaping (Any) -> ()){
        
        let baseUrl = "https://api.waifu.pics/"
        let complement = ApiService().genereteImgURL(type: .nfsw, categoryFws: nil, categoryNfws: category)
        
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
