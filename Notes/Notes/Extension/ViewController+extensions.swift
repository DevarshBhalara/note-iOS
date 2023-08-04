//
//  ViewController+extensions.swift
//  Notes
//
//  Created by Devarsh Bhalara on 04/08/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String = "", completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
            alertController.dismiss(animated: true)
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        
        present(alertController, animated: true)
    }
    
    
    func showOkAlert(title: String, message: String = "", completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
  
        present(alertController, animated: true)
    }
}
