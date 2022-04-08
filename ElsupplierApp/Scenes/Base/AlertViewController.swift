//
//  AlertViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class AlertViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var semiTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Variables
    
    let titleString: String
    let message: String
    let semititleString: String

    let actionTitle: String
    let cancelTitle: String
    
    var completion: (() -> ())?
    var onCancel: (() -> ())?

    // MARK: - LifeCycle
    init(title: String, message: String,semiString: String, actionTitle: String, cancelTitle: String = "Cancel", completion: (() -> ())?) {
        self.titleString = title
        self.message = message
        self.semititleString = semiString
        self.actionTitle = actionTitle
        self.cancelTitle = cancelTitle
        self.completion = completion
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
       // view.backgroundColor = .clear
        view.subviews.first?.cornerRadius = 10
        let button = UIButton()
        view.addSubIntrinsicView(button)
        view.sendSubviewToBack(button)
        button.addTarget(self, action: #selector(dismissClicked(_:)), for: .touchUpInside)
        titleLabel.text = titleString
        messageLabel.text = message
        semiTitleLabel.text = semititleString
        actionButton.setTitle(actionTitle.localized, for: .normal)
        cancelButton.setTitle(cancelTitle.localized, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction override func dismissClicked(_ sender: UIButton) {
        onCancel?()
        dismiss(animated: true)
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        dismissClicked(sender)
    }
    
    @IBAction func actionClicked(_ sender: UIButton) {
        dismiss(animated: true) {
            self.completion?()
        }
    }
    
}
