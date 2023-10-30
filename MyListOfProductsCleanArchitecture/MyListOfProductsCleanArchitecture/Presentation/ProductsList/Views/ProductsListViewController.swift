//
//  ProductsListViewController.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Domain
import RxCocoa
import RxSwift
import UIKit

class ProductsListViewController: UIViewController {
    private enum ConstantIdentifiers {
        static let productsListTableViewCell = "ProductsListTableViewCell"
    }
    
    private(set) var viewModel: ProductsListViewModel
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var productsListTableView: UITableView!
    lazy var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: ProductsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupHeader()
        setupObservers()
        setupTableView()
        configureRefreshControl()
        viewModel.onTriggeredEvent(event: .fetchProductsList)
    }
    
    private func setupHeader() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = NSLocalizedString("ProductsList", comment: "")
        navigationController?.navigationBar.backItem?.title = nil
    }
    
    private func setupObservers() {
        viewModel.stateObserver
            .observe(on: MainScheduler.instance)
            .map { newState -> [Product] in
                return newState.productsList
            }
            .distinctUntilChanged()
            .bind(to: productsListTableView.rx.items(cellIdentifier: ConstantIdentifiers.productsListTableViewCell, cellType: ProductsListTableViewCell.self)) { (row, item, cell) in
                cell.setupCell(product: item, delegate: self)
            }.disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        productsListTableView.register(UINib(nibName: ConstantIdentifiers.productsListTableViewCell, bundle: nil), forCellReuseIdentifier: ConstantIdentifiers.productsListTableViewCell)
        productsListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        productsListTableView.contentInsetAdjustmentBehavior = .never
        productsListTableView.insetsContentViewsToSafeArea = true
    }
    
    private func configureRefreshControl() {
        productsListTableView.refreshControl = UIRefreshControl()
        productsListTableView.refreshControl?.addTarget(self, action:
                                                #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        viewModel.onTriggeredEvent(event: .refreshProductsList)
        productsListTableView.refreshControl?.endRefreshing()
//        // dismiss search if in progress
        searchController.isActive = false
    }
}

//MARK: - Recipe Cell Delegate
extension ProductsListViewController: ProductsListTableViewCellDelegate {
    func didSelect(product: Product) {
        viewModel.onTriggeredEvent(event: .goToProductDetails(product: product))
    }
}
