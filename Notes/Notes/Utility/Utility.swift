//
//  Utility.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseAuth
import FirebaseFirestore

class Utility {
    
    private init() { }
    
    static let shared = Utility()
    
    func getCollectionReferenceForNotes() -> CollectionReference? {
        let currentUser = FirebaseAuth.Auth.auth().currentUser
        guard let uid = currentUser?.uid else {
            return nil
        }
        return Firestore.firestore().collection("notes").document(uid).collection("my_notes")
    }
}
