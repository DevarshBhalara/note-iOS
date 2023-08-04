//
//  ViewNoteCoordinator.swift
//  Notes
//
//  Created by Devarsh Bhalara on 03/08/23.
//

import UIKit

class ViewNoteCoordinator {
    
    var navigationController: UINavigationController

    var noteType: NoteType
    
    var id: String
    
    
    init(navigationController: UINavigationController, noteType: NoteType, id: String) {
        self.navigationController = navigationController
        self.noteType = noteType
        self.id = id
    }

    func start() {
        let viewNoteVC = FBAddNoteViewController.instantiate(from: .storyboard)
        viewNoteVC.viewNoteCoordinator = self
        viewNoteVC.noteType = noteType
        viewNoteVC.documentID = id
        navigationController.present(viewNoteVC, animated: true)
    }

}
