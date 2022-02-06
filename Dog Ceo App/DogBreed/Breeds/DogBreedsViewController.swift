//
//  DogBreedTableViewController.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import UIKit

class DogBreedsViewController<Presenter>:DogBreedBaseViewController<Presenter> where Presenter: DogBreedsPresenterProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Breeds"
    }
    
    func breedHasSubBreeds(section: Int) -> Bool {
        return presenter.getSubBreedCount(for: section) > 0
    }
    
    func configBreedLabel(_ label: UILabel?, section: Int) {
        configLabel(label,text: presenter.getBreedName(for: section), font: .boldSystemFont(ofSize: 14))
    }
    
    func configLabel(_ label: UILabel?, text: String?, font: UIFont) {
        label?.text = text?.capitalized
        label?.font = font
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getBreedCount()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subBreedCount = presenter.getSubBreedCount(for: section)
        return subBreedCount > 0 ? subBreedCount: 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath as IndexPath)
        if let subBreedName = presenter.getSubBreedName(for: indexPath) {
            configLabel(cell.textLabel, text: subBreedName, font: .systemFont(ofSize: 12))
        }
        else {
            configBreedLabel(cell.textLabel, section: indexPath.section)
        }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard breedHasSubBreeds(section: section) else {
            return nil
        }
        let headerView = UIView()
        headerView.backgroundColor = sectionBackgroundColor
        let label = UILabel()
        label.textAlignment = .center
        configBreedLabel(label, section: section)
        headerView.addSubView(label, equalTo: headerView)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return breedHasSubBreeds(section: section) ? 40: CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.getBreedName(for: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectBreed(for: indexPath)
    }
}
