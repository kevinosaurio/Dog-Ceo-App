//
//  DogBreedTableViewController.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import UIKit

class DogBreedBaseViewController<Presenter:DogBreedBasePresenterProtocol>: UITableViewController {
    let reuseIndentifier = "BreedCell"
    let sectionBackgroundColor: UIColor = .orange.withAlphaComponent(0.5)
    
    let presenter: Presenter
    
    lazy var loadingView:UIActivityIndicatorView = {
        let indicatorView:UIActivityIndicatorView = {
            guard #available(iOS 13, *) else {
                return UIActivityIndicatorView(style: .whiteLarge)
            }
            return UIActivityIndicatorView(style: .large)
        }()
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    
    init(style: UITableView.Style, presenter: Presenter){
        self.presenter = presenter
        super.init(style: style)
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        fatalError("init(coder:) has not been implemented")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIndentifier)
        DispatchQueue.main.async {
            self.presenter.callData()
        }
    }
}

extension DogBreedBaseViewController: DogBreedBaseViewProtocol {
    func showErrorView(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { [weak self] _ in
            self?.presenter.callData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        if loadingView.superview == nil {
            view.addSubViewWithEqualCenter(loadingView)
        }
        loadingView.startAnimating()
    }
    
    func refreshView() {
        loadingView.stopAnimating()
        tableView.reloadData()
    }
}
