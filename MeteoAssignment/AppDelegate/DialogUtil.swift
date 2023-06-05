//
//  DialogUtil.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class DialogUtil {
    static let shared = DialogUtil()
    
    func createAlertDialog(_ viewController: UIViewController,
                                            title:String,
                                            message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func createAlertDialogWithAction(_ viewController: UIViewController,
                                            title:String,
                                            message:String,
                                            buttonCancel:String,
                                            buttonGo:String,
                                            successHandler: @escaping () -> ()){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonGo, style: .default, handler: { (action: UIAlertAction!) in
            successHandler()
        }))
        
        alert.addAction(UIAlertAction(title: buttonCancel, style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
