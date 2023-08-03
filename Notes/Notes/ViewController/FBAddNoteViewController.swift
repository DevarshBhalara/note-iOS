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
    var complition: (() -> ())?
    var initailPlaceHolder = "Write here..."
    
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
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        if !(tfTitle.text?.isEmpty ?? true || tvContent.text.isEmpty )
        {
            viewModel.addNote(note: Note(title: tfTitle.text ?? "", content: tvContent.text ?? "", timeStamp: Timestamp(date: Date())))
        }
    }
    
    private func setupUI() {
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
