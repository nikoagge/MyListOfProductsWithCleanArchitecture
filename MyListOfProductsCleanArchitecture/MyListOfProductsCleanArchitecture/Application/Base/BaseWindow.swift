//
//  BaseWindow.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import UIKit
import Domain

class BaseWindow: UIWindow {
    private var feedbackInfoMessageView: FeedbackInfoMessageView?
    
    lazy var  presentableMessageTimeCounter: Int = { return 0 }()
    lazy var presentableMessageTimer: Timer = {
        return Timer()
    }()
    
    @objc private func fireTimer() {
        self.presentableMessageTimeCounter += 1
        print("....timer: \(presentableMessageTimeCounter) 🕰️")
        if self.presentableMessageTimeCounter >= 4 {
            presentableMessageTimer.invalidate()
            self.dismissingFeedbackMessage()
        }
    }
    
    func resetTimer() {
        print("....timer resetted 🕰️")
        presentableMessageTimeCounter = 0
        presentableMessageTimer.invalidate()
        presentableMessageTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func presentingFeedbackInfoMessage(feedbackInfoMessage: FeedbackInfoMessage) {
        if feedbackInfoMessageView != nil {
            dismissingFeedbackMessage {[weak self] in
                self?.resetTimer()
                self?.presentingFeedbackInfoMessage(feedbackInfoMessage: feedbackInfoMessage)
            }
            
            return
        }
        
        feedbackInfoMessageView = FeedbackInfoMessageView()
        feedbackInfoMessageView?.setupFeedbackInfoMessageContentView(with: feedbackInfoMessage)
        
        guard let feedbackInfoMessageView = feedbackInfoMessageView else {
            return
        }

        feedbackInfoMessageView.frame = CGRect(
            x: 20,
            y: -80,
            width: UIScreen.main.bounds.width - 40,
            height: 80
        )
        self.addSubview(feedbackInfoMessageView)
        
        let animator = UIViewPropertyAnimator(
            duration: 0.5,
            curve: .linear
        ) { [weak self] in
            let topPadding = self?.safeAreaInsets.top ?? 0
            feedbackInfoMessageView.frame.origin.y = topPadding + 13
        }
        animator.addCompletion { [weak self] _ in
            self?.resetTimer()
        }
        animator.startAnimation()
    }
    
    func dismissingFeedbackMessage(onCompletion: (()-> Void)? = nil) {
        guard let feedbackInfoMessageView = feedbackInfoMessageView else {
            return
        }
        
        let shrinkAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            feedbackInfoMessageView.frame.origin.y += 10
            feedbackInfoMessageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
        let dismissAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            feedbackInfoMessageView.frame.origin.y = -feedbackInfoMessageView.frame.size.height
        }
        
        shrinkAnimator.addCompletion({ (_) in
            dismissAnimator.startAnimation()
        })
        
        dismissAnimator.addCompletion { [weak self] _ in
            self?.feedbackInfoMessageView?.removeFromSuperview()
            self?.feedbackInfoMessageView = nil
            onCompletion?()
        }
        
        shrinkAnimator.startAnimation()
    }
}
