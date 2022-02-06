//
//  DogBreedImagesViewController.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation
import UIKit
import SDWebImage

class DogBreedDetailViewController<Presenter>:DogBreedBaseViewController<Presenter> where Presenter: DogBreedDetailPresenterProtocol {
    override func viewDidLoad() {
        title = presenter.breedName.capitalized
        if let subBreedName = presenter.subBreedName {
            title? += "/\(subBreedName)"
        }
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = CGFloat.leastNormalMagnitude
        }
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        super.viewDidLoad()
        tableView.register(DogBreedImageCell.self, forCellReuseIdentifier: reuseIndentifier)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getImagesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath) as! DogBreedImageCell
        cell.setUp(imageUrl: presenter.getImage(for:indexPath.row))
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
