//
//  ProductDetailsViewController.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 30/10/23.
//

import Domain
import Networking
import RxCocoa
import RxSwift
import UIKit


class ProductDetailsViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var productDescriptionLabel: UILabel!
    @IBOutlet var headerViewHeightConstraint: NSLayoutConstraint!

    @Injected(\.imageCacheManager)
    private var imageCacheManager: ImageCacheManager
    
    private(set) var viewModel: ProductDetailsViewModel
    private let disposeBag = DisposeBag()
    private let CONSTANT_HEADER_HEIGHT: CGFloat = 300
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupScrollView()
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(
            CGPoint(
                x: 0,
                y: -(CONSTANT_HEADER_HEIGHT)),
            animated: false
        )
    }
    
    private func setupHeader() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backItem?.title = nil
    }
    
    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(
            top: CONSTANT_HEADER_HEIGHT,
            left: 0,
            bottom: 0,
            right: 0
        )
        scrollView.delegate = self
    }
    
    private func setupObservers() {
        viewModel.stateObserver
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.navigationItem.title = state.selectedProduct.name
                self?.productDescriptionLabel.text = state.selectedProduct.description
                guard let imageId = state.selectedProduct.image else { return }
                self?.imageCacheManager.fetchImage(
                    for: imageId,
                    onCompletion: { image in
                        self?.headerImageView.image = image
                    }, errorCompletionHandler: { error in
                        debugPrint(error.localizedDescription)
                        self?.headerImageView.image = UIImage(named: "no_image_available")
                    })
                }).disposed(by: disposeBag)
    }
}

extension ProductDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y
        if y < 0 {
            headerViewHeightConstraint.constant = 0
        } else {
            headerViewHeightConstraint.constant = y
        }
    }
}
