//
//  FBAddNoteViewController.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import UIKit
import FirebaseFirestore

class FBAddNoteViewController: UIViewController, Storyboarded {
    
    // MARK: - outlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    
    // MARK: - variables
    private let viewModel = AddNoteViewModel()
    var complition: (() -> ())?
    var initailPlaceHolder = "Write here..."
    var noteType: NoteType?
    var documentID: String = ""
    var viewNoteCoordinator: ViewNoteCoordinator? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    private func bindViewModel() {
        viewModel.isAdded.bind { [weak self] isAdded in
            
            if isAdded {
                self?.dismiss(animated: true) {
                    self?.complition?()
                }
            }
        }
        
        viewModel.note.bind { [weak self] note in
            guard let note = note else {
                return
            }
            self?.setNoteData(note: note)
        }
    }
    
    private func setNoteData(note: Note) {
        lblTitle.text = ""
        tfTitle.text = note.title
        tvContent.text = note.content
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        if !(tfTitle.text?.isEmpty ?? true || tvContent.text.isEmpty )
        {
            if (documentID.isEmpty) {
                viewModel.addNote(note: Note(id: "", title: tfTitle.text ?? "", content: tvContent.text ?? "", timeStamp: Timestamp(date: Date())), noteType: .new)
            } else {
                viewModel.addNote(note: Note(id: documentID, title: tfTitle.text ?? "", content: tvContent.text ?? "", timeStamp: Timestamp(date: Date())), noteType: .edit)
            }
        }
    }
    
    private func setupUI() {
        switch noteType {
        case .new:
            lblTitle.text = "Add Note"
        case .edit:
            viewModel.getNote(documentID: documentID)
        case .none:
            break
        }
        
        tfTitle.layer.borderWidth = 0
        tfTitle.borderStyle = .none
        tvContent.delegate = self
        tvContent.text = initailPlaceHolder
        tvContent.textColor = .gray
    }
    
}

// MARK: - Textview delegate
extension FBAddNoteViewController: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == initailPlaceHolder {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = initailPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
}
