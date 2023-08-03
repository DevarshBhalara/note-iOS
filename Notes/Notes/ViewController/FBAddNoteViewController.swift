//
//  FBAddNoteViewController.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import UIKit
import FirebaseFirestore

class FBAddNoteViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    // MARK: - variables
    private let viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tfTitle.layer.borderWidth = 0
        tfTitle.borderStyle = .none
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(saveNote)), animated: true)
    }
    
    @objc func saveNote() {
        viewModel.addNote(note: Note(title: tfTitle.text ?? "", content: tvContent.text ?? "", timeStamp: Timestamp(date: Date())))
    }
}
