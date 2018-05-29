//
//  APIManager.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityIndicator
import AlamofireObjectMapper
import SVProgressHUD

typealias ApiCallback = (Bool, Any?) -> Void
var alamofireManager: SessionManager?
let apiKey = ""
var tokenKey: String?

class ApiManager: NSObject, UIApplicationDelegate {
    
    static var sharedintance = ApiManager()
    var reachability = NetworkReachabilityManager()
    
    //POST
    @discardableResult
    class func post<T> (url: String, params: [String: Any]?, timeOut: TimeInterval = 120, useTokenAndApiKey: Bool = false, responseClass: T.Type, callBack: @escaping ApiCallback) -> Request? where T: BaseModel {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOut // seconds
        configuration.timeoutIntervalForResource = timeOut
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        if useTokenAndApiKey, let token = tokenKey{
            configuration.httpAdditionalHeaders = ["Authorization": "\(apiKey)+\(token)"]
        }
        alamofireManager = SessionManager(configuration: configuration)
        debugLogRequest(url: url, param: params as [String : AnyObject]?)
        return alamofireManager?.request(url, method: .post, parameters: params).responseObject {(response: DataResponse<T>) in
            switch response.result {
            case .success:
                processResponse(response, callBack: callBack)
            case .failure(let error):
                SVProgressHUD.dismiss()
                debugPrint(error)
            }
        }
    }
    
    //GET
    @discardableResult
    class func get<T>(_ url: String, params: [String: Any]? = nil, useTokenAndApiKey: Bool = false, responseClass: T.Type, callBack: @escaping ApiCallback) -> Request? where T: BaseModel {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        debugLogRequest(url: url, param: params as [String : AnyObject]?)
        if useTokenAndApiKey, let token = tokenKey{
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Authorization": "\(apiKey)+\(token)"]
            alamofireManager = SessionManager(configuration: configuration)
            return alamofireManager!.request(url, method: .get, parameters: params).responseObject {(response: DataResponse<T>) in
                processResponse(response, callBack: callBack)
            }
        } else {
            return Alamofire.request(url, method: .get, parameters: params).responseObject {(response: DataResponse<T>) in
                processResponse(response, callBack: callBack)
            }
        }
    }
    
    //UPLOAD
    class func upload<T>(_ url: String, params: [String: Any]? = nil, useTokenAndApiKey: Bool = false, timeOut:TimeInterval = 240, responseClass: T.Type, callBack: @escaping ApiCallback) where T: BaseModel {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOut // seconds
        configuration.timeoutIntervalForResource = timeOut
        if useTokenAndApiKey, let token = tokenKey{
            configuration.httpAdditionalHeaders = ["Authorization": "\(apiKey)+\(token)"]
        }
        debugLogRequest(url: url, param: params as [String : AnyObject]?)
        alamofireManager = SessionManager(configuration: configuration)
        alamofireManager!.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            if let params = params {
                self.addMultipartFormData(params, multipartFormData: multipartFormData)
            }
        }, to: url, method: .post, headers: nil) { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseObject { (response: DataResponse<T>) in
                    processResponse(response, callBack: callBack)
                }
                
            case .failure(let encodingError):
                debugPrint(encodingError)
                callBack(false, nil)
            }
        }
    }
    
    class func addMultipartFormData(_ params: [String: Any], multipartFormData: Alamofire.MultipartFormData) {
        for (key, value) in params {
            // file upload
            if (value as AnyObject).isKind(of: NetData.self) == true, let netData = value as? NetData {
                multipartFormData.append(netData.data, withName: netData.param, fileName: netData.param, mimeType: netData.mimeType.rawValue)
            } else if let data = String(describing: value).data(using: String.Encoding.utf8) {
                // other param : string, int, bool
                multipartFormData.append(data, withName: key)
            }
        }
    }
    
    class func processResponse<T>(_ response: DataResponse<T>, showMessage: Bool = true, callBack: ApiCallback) where T: BaseModel {
        debugLogResponse(response: response)
        // In case status code is 200
        SVProgressHUD.dismiss()
        if response.result.isSuccess && response.response?.statusCode == 200 {
            callBack(true, response.result.value)
            // In case other status code, not 200
        } else {
            // In case error code not connnected to Internet
            if response.result.error?._code == NSURLErrorNotConnectedToInternet && showMessage {
                callBack(false, response.result.error)
            }
        }
    }
    
    /**
     Print the request info for debug
     
     - parameter url:     The URL string of the request.
     - parameter params:  The parameters. `nil` by default.
     */
    class func debugLogRequest(url: String, param: [String: AnyObject]? = nil) {
        debugPrint("--------------------------------START-------------------------------")
        debugPrint("==URL: \(url)")
        debugPrint("==PARAMS: \(String(describing: param))")
        debugPrint("---------------------------------------------------------------")
    }
    
    /**
     Print the response info for debug
     
     - parameter response: The Response object of Object mapper return from server : Used to store all response data returned from a completed `Request`.
     */
    class func debugLogResponse<T>(response: DataResponse<T>) where T: BaseModel {
        debugPrint("---------------------------------------------------------------")
        debugPrint("==RESPONSE")
        debugPrint(response)
        
        // try to parser data from server to Json and print out
        do {
            let parsedJSON = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments)
            let data = try JSONSerialization.data(withJSONObject: parsedJSON, options: .prettyPrinted)
            let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            debugPrint(string ?? "")
        } catch let error {
            debugPrint(error)
        }
        debugPrint ("--------------------------------END-------------------------------")
    }
    
    /**
     Creat custom Request Header for api
     
     - returns: dictionary contain header info
     */
    class func getHeader() -> [String: String] {
        let header = ["User-Agent": "iPhone"]
        debugPrint("==HEADER : \(header)")
        return header
    }
    
}

// MARK: class for upload

/// Mime type enum for upload
public enum MimeType: String {
    
    case imageJpeg = "image/jpeg"
    case imagePng  = "image/png"
    case imageGif  = "image/gif"
    case json      = "application/json"
    case unknown   = ""
    
    func getString() -> String? {
        switch self {
        case .imagePng, .imageJpeg, .imageGif, .json:
            return rawValue
        case .unknown:
            fallthrough
        default:
            return nil
        }
    }
    
}

/// NetData object for calling upload api
open class NetData {
    
    var data = Data()
    var mimeType = MimeType.unknown
    var param = ""
    
    public init() {
        // required by xcode
    }
    
    public init(data: Data, mimeType: MimeType, param: String) {
        self.data = data
        self.mimeType = mimeType
        self.param = param
    }
    
    public init(pngImage: UIImage, param: String) {
        data = UIImagePNGRepresentation(pngImage)!
        self.mimeType = MimeType.imagePng
        self.param = param
    }
    
    public init(jpegImage: UIImage, compressionQuanlity: CGFloat, param: String) {
        data = UIImageJPEGRepresentation(jpegImage, compressionQuanlity)!
        self.mimeType = MimeType.imageJpeg
        self.param = param
    }
    
}
