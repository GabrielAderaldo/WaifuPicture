//
//  UrlSessionExtended.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 06/06/22.
//

import Foundation

import Foundation

enum TYPE_RETURN_URL{
    case data
    case string
}


enum TYPE_STATUS_BASE{
    case CREATED
    case BAD_REQUEST
    case UNAUTHORIZED
    case FORBIDDEN
    case NOT_FOUND
    case NOT_FOUND_STATUS
}

extension URLSession{
    
    /**
            Function create to inpult params in the URL in a better away.
                - Parameter stringURL: Is the string to URL base
                - Parameter paramets: is the dictionary with contains all of the params to inpult in a URL
            
                - Error Throw: `The website of WWW original`
                        
                - Returns: return the url with the params encoded.
     
     */
   private func putParamtersInsideUrl(stringURL:String,paramets:[String:String]?) -> URL{
        
        guard var url = URLComponents(string: stringURL) else{
            return URL(string: "http://info.cern.ch/hypertext/WWW/TheProject.html")!
        }
       
       let queryItems = paramets?.compactMap({ (key,value) in
           return URLQueryItem(name: key, value: value)
       })
       
       url.queryItems = queryItems
       
       url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
       
       guard let urlStringComponent = url.string else{
           return URL(string: "http://info.cern.ch/hypertext/WWW/TheProject.html")!
       }
       
       guard let urlFinal = URL(string: urlStringComponent) else{
           return URL(string: "http://info.cern.ch/hypertext/WWW/TheProject.html")!
       }
        
       return urlFinal
    }
    
    private func handleDataEncodingToString(data: Data?) -> String{
        guard let data = data else {
            return "Error because data are nil"
        }
        
        guard let dataString = String(data: data, encoding: .utf8) else{
            return "Fail to convert data to string"
        }
        
        return dataString
        
    }
    
    
    private func handleDataEncodingToData(data: Data?) -> Data{
        guard let data = data else {
            return Data.init()
        }
        
        return data
        
    }
    
    private func statusHttpReturn(statusCode:Int)-> TYPE_STATUS_BASE{
        switch statusCode{
            case 200:
                return .CREATED
            case 400:
                return .BAD_REQUEST
            case 401:
                return .UNAUTHORIZED
            case 403:
                return .FORBIDDEN
            case 404:
                return .NOT_FOUND
            default:
                return .NOT_FOUND_STATUS
        }
    }
    
    
    //TODO: Fazer uma boa documentação sobre essa função
    /**
            This function do the get information in the URL.
                - Parameter url: is the url in string
                - Parameter paramets: is the dictionary with contains all of the params URL
                - Parameter typeReturn: This parameters need you choose who is your type sucess
            
                - SUCESS Throw:  [STRING] `The string of content of the get URL`
                
                - SUCESS Throw:  [DATA] `The data(binary) of content of the get URL`
                        
                - FAIL Throw: `The error of any problem is possible happend in process of function, and de data wrong`
     
     */
    static func httpGet(url:String,paramets:[String:String]?,typeReturn: TYPE_RETURN_URL,sucess onSucess:@escaping(Any) -> Void, failure onFailure: @escaping(Any) -> Void){
        
        let urlValid = self.shared.putParamtersInsideUrl(stringURL: url, paramets: paramets)
        
        let task = URLSession.shared.dataTask(with: urlValid) { (data, res, err) in
            
            if let err = err {
                onFailure(err)
            }
            
            guard let response = res as? HTTPURLResponse else {
                return
            }
            
            let enumStatus = self.shared.statusHttpReturn(statusCode: response.statusCode)
            
            //TODO: WRITE THIS PART IN A BETTER AWAY
            
            switch typeReturn {
            case .data:
                
                switch enumStatus {
                case .CREATED:
                    let data = self.shared.handleDataEncodingToData(data: data)
                    onSucess(data)
                case .BAD_REQUEST:
                    let data = self.shared.handleDataEncodingToData(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .UNAUTHORIZED:
                    let data = self.shared.handleDataEncodingToData(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .FORBIDDEN:
                    let data = self.shared.handleDataEncodingToData(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .NOT_FOUND:
                    let data = self.shared.handleDataEncodingToData(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .NOT_FOUND_STATUS:
                    let data = self.shared.handleDataEncodingToData(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                }
                
                
            case .string:
                switch enumStatus {
                case .CREATED:
                    let data = self.shared.handleDataEncodingToString(data: data)
                    onSucess(data)
                case .BAD_REQUEST:
                    let data = self.shared.handleDataEncodingToString(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .UNAUTHORIZED:
                    let data = self.shared.handleDataEncodingToString(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .FORBIDDEN:
                    let data = self.shared.handleDataEncodingToString(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .NOT_FOUND:
                    let data = self.shared.handleDataEncodingToString(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                case .NOT_FOUND_STATUS:
                    let data = self.shared.handleDataEncodingToString(data: data)
                    onFailure(["data":data,"statusCode":response.statusCode])
                }
            }
          
        }
        
        task.resume()
        
    }
    
    
}
