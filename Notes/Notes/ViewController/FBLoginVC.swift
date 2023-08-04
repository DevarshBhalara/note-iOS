//
//  FBLoginVC.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import UIKit

class FBLoginVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    
    // MARK: - variables
    private let viewModel = FBLoginViewModel()
    var authCoordinator: AuthCoordinator? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.loginSuccess.bind { [weak self] success in
            
            guard let self = self else {
                return 
            }
            
            self.btnLogin.configuration?.showsActivityIndicator = false
            if success {
                guard let vc = self.storyboard?.instantiateViewController(identifier: "FBAllNotesViewController") as? FBAllNotesViewController else {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        btnLogin.configuration?.showsActivityIndicator = true
        if let email = tfEmail.text, let password = tfPassword.text {
            if !(email.isEmpty && password.isEmpty) {
                viewModel.login(email: email, password: password)
            }
        }
    }
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
        authCoordinator?.goToSignup()
    }
}
