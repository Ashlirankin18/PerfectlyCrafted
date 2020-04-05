//
//  DetailedViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/5/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class DetailedViewController: UIViewController {
    
    private enum CardState {
        case expanded
        case collapsed
    }
    
    private let cardHeight: CGFloat = 560
    private let cardHandleArea: CGFloat = 60
    private var isCardVisible: Bool = false
    private var animationProgressWhenInterrupted: CGFloat = 0.0
    
    private var nextState: CardState {
        return isCardVisible ? .collapsed : .expanded
    }
    
    private lazy var detailDescriptionViewController: DetailedDescriptionViewController = DetailedDescriptionViewController()
    
    private var runningAnimations = [UIViewPropertyAnimator]()
   
    private let post: Post
    
    private let localImageManager = try? LocalImageManager()
    
    @IBOutlet private weak var entryImageView: UIImageView!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    init?(coder: NSCoder, post: Post) {
        self.post = post
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureNavigationItems()
        configureLabels()
        configureImageView()
        detailDescriptionViewController.delegate = self
        detailDescriptionViewController.view.frame = CGRect(x: 0, y: view.frame.height, width: view.bounds.width, height: cardHeight)
        detailDescriptionViewController.view.clipsToBounds = true
        addChild(detailDescriptionViewController)
        view.addSubview(detailDescriptionViewController.view)
        animateTransitionIfNeeded(state: nextState, duration: 1.0)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func configureNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: CircularButton.backButton)
    }
    private func configureLabels() {
        guard let createdDate = post.createdDate else {
            return
        }
        dateLabel.text = DateFormatter.format(date: post.eventDate ?? createdDate)
        titleLabel.text = post.title?.capitalized
    }
    
    private func configureImageView() {
        guard let photoIdendifier = post.photoIdentfier else {
            return
        }
        localImageManager?.loadImage(forKey: photoIdendifier) { [weak self] (result) in
            switch result {
            case let .failure(error):
                print(error)
                self?.entryImageView.backgroundColor = .white
            case let .success(image):
                self?.entryImageView.image = image
            }
        }
    }
    
    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.detailDescriptionViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.detailDescriptionViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleArea
                }
            }
            frameAnimator.addCompletion { _ in
                self.isCardVisible = !self.isCardVisible
                self.runningAnimations.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.detailDescriptionViewController.view.layer.cornerRadius = 20.0
                case .collapsed:
                    self.detailDescriptionViewController.view.layer.cornerRadius = 0
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
        }
    }
    
    private func startIntractiveTransition(state: CardState, duration: TimeInterval) {
        
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractionTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.0)
        }
    }
    
    @IBAction private func editButtonTapped(_ sender: CircularButton) {
    }
    
    @IBAction private func deleteButtonTapped(_ sender: CircularButton) {
    }
    
    @IBAction private func shareButtonTapped(_ sender: CircularButton) {
    }
}

extension DetailedViewController: DetailedDescriptionViewControllerDelegate {
    
      // MARK: - DetailedDescriptionViewControllerDelegate
    
    func panGestureDidBegin(_ cardViewController: DetailedDescriptionViewController) {
        startIntractiveTransition(state: nextState, duration: 1.0)
    }
    
    func panGestureDidChange(_ cardViewController: DetailedDescriptionViewController, with translation: CGPoint) {
    var fractionComplete = translation.y / cardHeight
        
        fractionComplete = isCardVisible ? fractionComplete : -fractionComplete
        updateInteractiveTransition(fractionCompleted: fractionComplete)
    }
    
    func panGestureDidEnd(_ cardViewController: DetailedDescriptionViewController) {
         continueInteractionTransition()
    }
}
