//
//  ViewController.swift
//  TestAppMockiApi
//
//  Created by shizo663 on 15.03.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Properties -
    
    var feedModel: FeedModel?
    
    //MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: Cells.textCellNib.rawValue, bundle: nil)
            let imageNib = UINib(nibName: Cells.imageCellNib.rawValue, bundle: nil)
            tableView.register(imageNib, forCellReuseIdentifier: Cells.imageCellIdentifier.rawValue)
            tableView.register(nib, forCellReuseIdentifier: Cells.textCellIdentifier.rawValue)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    //MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: - Functions -
    
    private func loadData() {
        NetworkManager.fetchData { [weak self] (data) in
            guard let self = self else { return }
            self.feedModel = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - TableView extension -
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = feedModel?.content?.count {
            return count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return feedModel?.content?[section].texts?.count ?? 1
        case 1:
            return feedModel?.content?[section].images?.count ?? 1
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return feedModel?.content?[section].sectionTitle
        case 1:
            return feedModel?.content?[section].sectionTitle
        default:
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCellIdentifier.rawValue) as! TextTableViewCell
        let imageCell = tableView.dequeueReusableCell(withIdentifier: Cells.imageCellIdentifier.rawValue) as! ImageTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textsLabel.text = feedModel?.content?[indexPath.section].texts?[indexPath.row]
            return cell
        case 1:
            if let imageUrls = feedModel?.content?[indexPath.section].images?[indexPath.row] {
                imageCell.configure(imageUrls)
                imageCell.layoutIfNeeded()
            }
            return imageCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: VC.detailVc.rawValue) as! DetailViewController
        switch indexPath.section {
        case 0:
            let data = feedModel?.content?[indexPath.section].texts?[indexPath.row]
            vc.someText = data
        case 1:
            let data = feedModel?.content?[indexPath.section].images?[indexPath.row]
            vc.imageUrl = data
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

