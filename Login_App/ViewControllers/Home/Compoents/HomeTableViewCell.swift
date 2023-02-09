//
//  HomeTableViewCell.swift
//  Login_App
//
//  Created by Henadzi on 01/12/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel?
    
    func setup(with text: String) {
        titleLabel?.text = text
    }
}
