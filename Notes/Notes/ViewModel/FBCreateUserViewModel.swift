//
//  FBCreateUser.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class FBCreateUserViewModel {
    
    // MARK: - Variables
    let registerSuccess = Dynamic<Bool>(false)
    var vc: UIViewController? = nil
    
    
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
    
    func signUpWithGoogle() {
        guard let vc = vc else {
            return
        }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self]
            result, error in
            
            if let error = error {
                print("\(error)")
                return
            }
            
            guard let result = result else {
                print("not found")
                return
            }
            guard let id = result.user.idToken?.tokenString else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: id, accessToken: result.user.accessToken.tokenString)
            self?.createUserWithGoogle(credential: credential)
        }
    }
    
    func createUserWithGoogle(credential: AuthCredential) {
        
        FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] result, error in
            
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
