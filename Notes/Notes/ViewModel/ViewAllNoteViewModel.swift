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
                    self.notes.value = Note.convertToModelArray(dictionaryArray: documentArray)
                }
                
            }
    }
}
