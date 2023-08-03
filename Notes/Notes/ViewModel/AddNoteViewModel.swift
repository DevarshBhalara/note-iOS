//
//  AddNoteViewModel.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseFirestore

class AddNoteViewModel {
    
    // MARK: - variables
    let isAdded = Dynamic<Bool>(false)
    var documentReference: DocumentReference? = nil
    
    func addNote(note: Note) {
        
        guard let documentRef = Utility.shared.getCollectionReferenceForNotes() else {
            return
        }
        
        documentReference = documentRef.document()
        let data = note.toDictionary()
        documentReference?.setData(data) { error in
            if let error = error {
                print("Error \(error)")
            } else {
                print("Added")
            }
        }
        
    }
}
