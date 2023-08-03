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
    let note = Dynamic<Note?>(nil)
    var documentReference: DocumentReference? = nil
    
    func addNote(note: Note, noteType: NoteType) {
        
        if noteType == .edit {
            guard let documentRef = Utility.shared.getCollectionReferenceForNotes()?.document(note.id) else {
                return
            }
            documentReference = documentRef
        } else {
            guard let documentRef = Utility.shared.getCollectionReferenceForNotes()?.document() else {
                return
            }
            documentReference = documentRef
        }

        let data = note.toDictionary()
        documentReference?.setData(data) { [weak self] error in
            if let error = error {
                print("Error \(error)")
            } else {
                self?.isAdded.value = true
                print("Added")
            }
        }
    }
    
    func getNote(documentID: String) {
        
        guard let collectionRef = Utility.shared.getCollectionReferenceForNotes() else {
            return
        }
        
        collectionRef.document(documentID).getDocument { [weak self] documentSnapshot, error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                print("error \(error)")
            }
            
            guard let documentData = documentSnapshot?.data() else {
                print("error")
                return
            }
            self.note.value = Note.convertToModel(dictionary: documentData, id: documentID)
        }
    }
}
