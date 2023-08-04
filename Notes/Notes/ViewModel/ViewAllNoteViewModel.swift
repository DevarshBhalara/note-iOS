//
//  ViewAllNoteViewModel.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 03/08/23.
//

import Foundation
class ViewAllNoteModel {
    
    // MARK: - variables
    let error = Dynamic<String>("")
    let notes = Dynamic<[Note]>([])
    let deleteSuccess = Dynamic<Bool>(false)
    
    func getAllNotes() {
        Utility.shared.getCollectionReferenceForNotes()?.getDocuments { [weak self]
                querySnapshot, error in
                
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    // Handle the error appropriately
                    self.error.value = "Some Error Occurred: \(error.localizedDescription)"
                    return
                }
                
                if let querySnapshot = querySnapshot {
                    let documentArray = querySnapshot.documents.map { $0.data() }
                    print(documentArray)
                    self.notes.value = Note.convertToModelArray(dictionaryArray: documentArray, ids: querySnapshot.documents.map { $0.documentID })
                    print(notes.value)
                }
                
            }
    }
    
    func deleteNote(id: String) {
        Utility.shared.getCollectionReferenceForNotes()?.document(id).delete() { [weak self]
             error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.error.value = "Some Error Occurred: \(error.localizedDescription)"
                return
            }
            self.deleteSuccess.value = true
        }
    }
}
