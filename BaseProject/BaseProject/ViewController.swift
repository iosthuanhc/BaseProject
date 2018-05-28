//
//  ViewController.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getListCatNewRequest()
    }

    func postNewContact() {
        let request = BusinessPostNewContactRequest()
        request.business_id = "businessID"
        request.name = "name.text"
        request.email = "email.text"
        request.phone = "phone.text"
        request.content = "content.text"
        ApiManager.post(url: ApiUrl.businessAddContact.url, params: request.toJSON(), useTokenAndApiKey: true, responseClass: BusinessPostNewContactResponse.self) { (success, reponse) in
            if success, let response = reponse as? BusinessPostNewContactResponse {
                if response.message == "Success" {
                    // Success
                }
            }
        }
    }
    
    func getListCatNewRequest() {
        weak var mySelf = self
        ApiManager.get(ApiUrl.getListCatsView.url, params: nil, responseClass: GetListCatsNewResponse.self, callBack: { (sucess, response) -> Void in
            if sucess, let response = response as? GetListCatsNewResponse {
                if let data = response.data, data.count > 0 {
                   
                }
            }
        })
    }
   
    func createRegisBusinessRequest() {
        let request = RegisBusinessRequest()
        request.username = "userNameTextField.text"
        request.email = "emailTextField.text"
        request.password = "passwordTextFIeld.text"
        request.password_confirmation = "confirmPassword.text"
        request.name = "nameTextField.text"
        request.branch = "industryTextField.text"
        request.province = "cityTextField.text"
        request.address = "addressTextField.text"
        request.phone = "phoneTextField.text"
        request.website = "websiteTextField.text"
        weak var mySelf = self
        ApiManager.upload(ApiUrl.businessRegister.url, params: request.toJSON(), responseClass: RegisBusinessResponse.self, callBack: { (sucess, response) -> Void in
            if sucess, let response = response as? RegisBusinessResponse {
                if let data = response.data {
                    
                } else {
                    // error
                }
            }
        })
    }

    func makeAddProductRequest() {
        let productImage = UIImage(named: "abc")
        var params = [String:Any]()
        params["title"] = "titleTextFiled.text"
        params["description"] = "descriptionTextView.text"
        params["attachment"] = NetData(data: UIImagePNGRepresentation(productImage!)!, mimeType:MimeType.ImagePng, param: "attachment")
        weak var mySelf = self
        let url = ApiUrl.addProducts.url
        ApiManager.upload(url, params: params, useTokenAndApiKey: true, responseClass: RegisBusinessResponse.self, callBack: { (sucess, response) -> Void in
            if sucess, let response = response as? RegisBusinessResponse {
                if let data = response.data {
                    let alertController = UIAlertController(title: "Notification", message: "Add product success!", preferredStyle:UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    { action -> Void in
                        mySelf?.dismiss(animated: true)                    })
                    mySelf?.present(alertController, animated: true, completion: nil)
                } else {
                    // Error
                }
            }
        })
    }

}

