//
//  AllNoteCell.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 03/08/23.
//

import UIKit

class AllNoteCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func configureCell(note: Note) {
        lblTitle.text = note.title
        lblContent.text = note.content
    }
}
