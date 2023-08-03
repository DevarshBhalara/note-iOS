//
//  FBCreateUser.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import UIKit

class FBCreateUserVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConformPassword: UITextField!
    
    // MARK: - variables
    private let viewModel = FBCreateUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
        viewModel.createUser(email: tfEmail.text ?? "", password: tfPassword.text ?? "")
    }
}
