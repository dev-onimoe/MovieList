//
//  Service.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias SOAPICompletionHandler = (_ error:Error?, _ response:JSON?) -> Void

class Service: NSObject {
    
    class HTTPUtils {
        class func getHeaders() -> HTTPHeaders {
            let headers: HTTPHeaders = [
                "time_zone": TimeZone.current.identifier,
            ]
            return headers
        }
    }
    
    static var instance: Service!
    
    // SHARED INSTANCE
    class func sharedInstance() -> Service{
        self.instance = (self.instance ?? Service())
        return self.instance
    }
    
    func callApi(_ strApiName:String,isLoader: Bool,
                 isShowErrMsg: Bool = true,
                 param : [String : Any]?,
                 method: HTTPMethod,
                 header:HTTPHeaders?,
                 arrImages:[(image: UIImage?,name:String,fileUrl: URL?)]? = nil,
                 encoding:ParameterEncoding = URLEncoding(),
                 completionHandler:@escaping SOAPICompletionHandler){
        if (Connectivity.isConnectedToInternet()){
            if isLoader{
                Utility.showProgressHUD()
            }
            let url = strApiName
            print("API:::::::::::::::>>>>>>>>>\(url)")
            if let param = param {
                print("parameters:::::::::::::::>>>>>>>>>\(JSON(param))")
            }
            
            
            if let encodeURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed){
                
                AF.request(encodeURL, method: method, parameters: param, encoding: encoding, headers: header).responseData(completionHandler: { (responseData) in
                    
                    if isLoader{
                        Utility.hideProgressHUD()
                    }
                    guard let statusCode = responseData.response?.statusCode else {return}
                    
                    if (200..<300).contains(statusCode) {
                       
                        if let value = responseData.value{
                            let json = JSON(value)
                            //print("API:::::::::::::::>>>>>>>>>\(url)")
                            //print("result:::::::::::::::>>>>>>>>>\(json)")
                            completionHandler(nil,json)
                        }else{
                            if let error = responseData.error{
                                completionHandler(error,nil)
                            }
                        }
                    }else {
                        
                        Utility.showErrorMessage(msg: "There was an error")
                    }
                    
                    
                })
            }
            
        }else{
            Utility.showErrorMessage(msg: "No Internet Connection")
            Utility.hideProgressHUD()
        }
    }
    
    
    private var reachability: NetworkReachabilityManager!
    private func monitorReachability() {
        reachability = NetworkReachabilityManager.default
        reachability.startListening { status in
            print("Reachability Status Changed: \(status)")
        }
    }
    
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class Response {
    
    var check : Bool
    var description : String
    var object: Any?
    
    init(check : Bool, description : String, object : Any? = nil) {
        self.check = check
        self.description = description
        self.object = object
    }
}
