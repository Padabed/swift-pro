//
//  CellInnerViewController.swift
//  Login_App
//
//  Created by Henadzi on 05/12/2022.
//

import UIKit

protocol CellInnerViewControllerDelegate {
    func buttonTapped(title: String)
}

class CellInnerViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var longreadLabel: UILabel!
    @IBOutlet private var bgImageView: UIImageView!
    
    @IBAction private func actionButtonTapped(_ sender: UIButton) {
        redButtonTapped?(itemData!.title)
    }
    
    private var itemData: HomeInnerVCProtocol?
    private var redButtonTapped: ((String) -> Void)?

    func setup(itemData: HomeInnerVCProtocol, redButtonTapped: @escaping (String) -> Void) {
        self.itemData = itemData
        self.redButtonTapped = redButtonTapped
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
    private func setupAppearance() {
        guard let itemData else { return }

        titleLabel.text = itemData.title
        subtitleLabel.text = "itemData.subtitle"
        
        switch itemData.type {
        case .longread(let text):
            longreadLabel.text = text
            longreadLabel.numberOfLines = 0
        case .color(let color):
            view.backgroundColor = color
        case .image(let image):
            bgImageView.image = image
            bgImageView.contentMode = .scaleToFill
        }
    }
}
