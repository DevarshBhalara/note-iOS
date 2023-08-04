//
//  FBCreateUser.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import UIKit

class FBCreateUserVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConformPassword: UITextField!
    
    // MARK: - variables
    private let viewModel = FBCreateUserViewModel()
    var signupCoordinator: SignupCoordinator? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.registerSuccess.bind { [weak self] success in
            
            guard let self = self else {
                return
            }
            if success {
                self.showOkAlert(title: "Registered Successfully") {
                    self.signupCoordinator?.gotologin()
                }
            } else {
                self.showOkAlert(title: "Please try again later!")
            }
        }
    }
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
        viewModel.createUser(email: tfEmail.text ?? "", password: tfPassword.text ?? "")
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        signupCoordinator?.gotologin()
    }
}
