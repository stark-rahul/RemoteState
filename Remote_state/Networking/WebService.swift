//
//  WebService.swift
//  TokopediaMiniProject
//
//  Created by Rahul on 16/01/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class WebServices: UIViewController {

    static let shared = WebServices()
    private var baseUrl = ""
    /**
     Call Webservice with single model

     - Parameter type:                   Mappable model for this API Call
     - parameter endPointURL:            EndPoint URL for this API. Default: empty string.
     - parameter urlMethod:              Http method type.
     - parameter showLoader:             Loader show and hide.
     - parameter Params:                 Parameters for this API. Default: nil
     - parameter accessTokenAdd:         Add access token for this Api.  Default: true
     - parameter failureReturen:         Failure returen to view for this Api.  Default: false
     - Completion:                       Return model response to the handler
     */

    func requestToApi ( with endPointURL: String,
                        urlMethod: HTTPMethod!,
                        params: Parameters? = nil,
                        completion: @escaping(_ result: Any) -> ()
                      ) {
        
        guard NetworkState.isConnected() else {
            self.showErrorMessage(message: "noNetwork")
            return
        }
        
        //Form base url & add header (if both same )
        var url = ""
        if baseUrl == endPointURL {
            url = baseUrl
        }else {
            url = baseUrl + endPointURL
        }
        
//        var headers: HTTPHeaders = [Content.Contents.RequestType : Content.Contents.RequestValue,
//                                    Content.Contents.ContentType: Content.Contents.ContentValue]
        
        var headers: HTTPHeaders = [:]
        
        
        print("Request URL: \(url)")
        print("Parameters: \(params ?? [:])")
        
        //Alamofire request
        AF.request(url, method: urlMethod, parameters: params, headers: headers).validate().responseJSON { response in
            
            
            //Response validate
            switch response.result {
                case .success:
                    print("response:--->",response.response as Any)
                    print(response.value as? [String : Any])
                    print(JSON(response.value))
                    completion(response.value)
                    
                case .failure:
                    print("ERROR---\(response.error?.localizedDescription ?? "API ERROR")")
                    
                    if let responseJSON = response.value as? [String: AnyObject]  {
                        print("Error reading response")
                        let error = responseJSON["error"] as? [String: AnyObject]
                        let msg = error?["msg"] as? String
                        print("msg: ",msg)
                    }
            }
        }
        
        
    }
    
    //Show error message
    func showErrorMessage(message: String) {
        if  message.count > 40 {
            DispatchQueue.main.async {
                  let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
                     //okButton Action
                let okButton = UIAlertAction(title: "Constants.string.SOk", style: UIAlertAction.Style.default) {
                         (result : UIAlertAction) -> Void in
                         //self.onTapAction?(0)
                     }
                     alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

            }}else{
        DispatchQueue.main.async {
            print(message)
        }
        }
    }
}

//MARK: - NetworkState

class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
