//
//  FeedbackInfoMessageView.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Domain
import UIKit

@IBDesignable
class FeedbackInfoMessageView: UIView {
    @IBOutlet var feedbackInfoMessageContentView: UIView!
    @IBOutlet weak var feedbackInfoMessageLabel: UILabel!
    
    let XIB_NAME = "FeedbackInfoMessageView"
    private var feedbackInfoMessage: FeedbackInfoMessage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        feedbackInfoMessageContentView?.prepareForInterfaceBuilder()
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        feedbackInfoMessageContentView = view
        feedbackInfoMessageContentView.clipsToBounds = true
        feedbackInfoMessageContentView.layer.cornerRadius = 13
        feedbackInfoMessageContentView.clipsToBounds = true
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: XIB_NAME, bundle: bundle)
        
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    func setupFeedbackInfoMessageContentView(with feedbackInfoMessage: FeedbackInfoMessage) {
        self.feedbackInfoMessage = feedbackInfoMessage
        feedbackInfoMessageLabel.text = feedbackInfoMessage.message
        
        switch feedbackInfoMessage.feedbackInfoMessageType {
        case .error:
            feedbackInfoMessageContentView.backgroundColor = .systemRed
            
        case .info:
            feedbackInfoMessageContentView.backgroundColor = .systemBlue
            
        case .success:
            feedbackInfoMessageContentView.backgroundColor = .systemGreen
        }
    }
}
