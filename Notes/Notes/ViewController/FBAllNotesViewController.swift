//
//  FBAllNotesViewController.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import UIKit

class FBAllNotesViewController: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var clvNotes: UICollectionView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var btnAddNote: UIButton!
    
    // MARK: - variable
    private let viewModel = ViewAllNoteModel()
    private var notes: [Note] = []
    var homeCoordinator: HomeCoordinator? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    @IBAction func btnLogoutAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        homeCoordinator?.gotoAuth()
    }
    
    private func bindViewModel() {
        
        viewModel.notes.bind { [weak self] notes in
            self?.notes = notes
            self?.aiLoading.stopAnimating()
            self?.clvNotes.reloadData()
        }
        
        viewModel.deleteSuccess.bind { [weak self] isDelete in
            if isDelete {
                self?.viewModel.getAllNotes()
            }
        }
    }
    
    private func setupUI() {
        aiLoading.startAnimating()
        btnAddNote.layer.cornerRadius = btnAddNote.frame.width / 2
        viewModel.getAllNotes()
    }
    
    @IBAction func btnAddNoteAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FBAddNoteViewController") as? FBAddNoteViewController else {
            return
        }
        vc.complition = { [weak self] in
            self?.aiLoading.startAnimating()
            self?.viewModel.getAllNotes()
        }
        vc.noteType = .new
        navigationController?.present(vc, animated: true)
    }
}

// MARK: - Collection view datasource
extension FBAllNotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllNoteCell", for: indexPath) as? AllNoteCell else {
            return UICollectionViewCell()
        }
        cell.deleteNote = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.showAlert(title: "Are you sure?") {
                self.aiLoading.startAnimating()
                self.viewModel.deleteNote(id: self.notes[indexPath.row].id)
                self.clvNotes.reloadData()
            }
        }
        cell.configureCell(note: notes[indexPath.row])
        return cell
    }
}


// MARK: - Collection view delegate
extension FBAllNotesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 20, height: view.bounds.height / 6 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FBAddNoteViewController") as? FBAddNoteViewController else {
            return
        }
        vc.complition = { [weak self] in
            self?.aiLoading.startAnimating()
            self?.viewModel.getAllNotes()
        }
        vc.documentID = notes[indexPath.row].id
        vc.noteType = .edit
        navigationController?.present(vc, animated: true)
    }
}
