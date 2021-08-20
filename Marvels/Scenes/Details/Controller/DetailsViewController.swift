//
//  DetailsViewController.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var viewModel: DetailsViewModel!
    var likeButton = UIButton(type: .system)
    var selectedLikeButton = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTableView()
        setupNavigationButton()
        viewModel.delegate = self
        viewModel.requestLike()
        self.navigationItem.title = viewModel.detailModel.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.likeArray = StoreManager.shared.getLikesArray()
        setupNavigationButton()
        viewModel.tableView.reloadData()
    }
    
    
    func setupNavigationButton() {
        
        likeButton.frame = CGRect(x: 0, y: 0, width: 45, height: 30)
        let item = UIBarButtonItem(customView: likeButton)
        if self.selectedLikeButton {
            likeButton.setImage(UIImage(named: "fillstar"), for: .normal)
        }
        else {
            likeButton.setImage(UIImage(named: "blankstar"), for: .normal)
        }
        likeButton.addTarget(viewModel, action: #selector(viewModel.likeButtonTapped), for: .touchUpInside)
        self.navigationItem.setRightBarButtonItems([item], animated: true)
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    
    func characterReview(url: String) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let reviewVC = mainStoryboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController {
            reviewVC.getUrl = url
            self.navigationController?.pushViewController(reviewVC, animated: true)
        }
    }
    
    
    func buttonImage(isLike: Bool) {
        self.selectedLikeButton = isLike
        setupNavigationButton()
        viewModel.tableView.reloadData()
    }
    
    func changedStatus(status: BaseViewController.RequestStatus) {
        
        switch status {
            case .completed(let error):
                if error != nil {
                    print("error")
                }
                else {
                    viewModel.tableView.reloadData()
                }
            default: break
        }
    }
    
    
}
