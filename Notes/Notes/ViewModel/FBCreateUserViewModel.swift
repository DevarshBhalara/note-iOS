//
//  FBCreateUser.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseAuth

class FBCreateUserViewModel {
    
    // MARK: - Variables
    let registerSuccess = Dynamic<Bool>(false)
    
    func createUser(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.registerSuccess.value = false
                return
            }
            self.registerSuccess.value = true
        }
    }
}
