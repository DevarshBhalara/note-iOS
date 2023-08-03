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
    
    private func bindViewModel() {
        viewModel.notes.bind { [weak self] notes in
            self?.notes = notes
            self?.clvNotes.reloadData()
        }
    }
    
    private func setupUI() {
        btnAddNote.layer.cornerRadius = btnAddNote.frame.width / 2
        viewModel.getAllNotes()
    }
    
    @IBAction func btnAddNoteAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FBAddNoteViewController") as? FBAddNoteViewController else {
            return
        }
        vc.complition = { [weak self] in
            self?.viewModel.getAllNotes()
            self?.clvNotes.reloadData()
        }
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
        
        cell.configureCell(note: notes[indexPath.row])
        return cell
    }
}


// MARK: - Collection view delegate
extension FBAllNotesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 20, height: view.bounds.height / 6 - 20)
    }
    
}
