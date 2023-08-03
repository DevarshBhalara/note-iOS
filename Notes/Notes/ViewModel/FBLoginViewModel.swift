//
//  FBLoginViewModel.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseAuth

class FBLoginViewModel {
    
    // MARK: - Variables
    let loginSuccess = Dynamic<Bool>(false)
    
    func login(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                print("Invalid Password")
                self.loginSuccess.value = false
                return
            }
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            self.loginSuccess.value = true
            print(result?.user.uid)
            
        }
    }
}
