//
//  MarvelViewController.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import UIKit
import Foundation

class MarvelViewController: BaseViewController {
    
    @IBOutlet weak var viewModel: MarvelListViewModel!
    var designButton = UIBarButtonItem()
    var designButtonTitle = "List"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchMarvels()
        viewModel.setupCollectionView()
        setupNavigationController()
        setupSearchBar()
        setFloatingButton()
        viewModel.delegate = self
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.likeArray = StoreManager.shared.getLikesArray()
        viewModel.setupCollectionView()
    }
    
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.navigationItem.title = "Marvel List"
        self.navigationController?.navigationBar.backgroundColor = UIColor.navigationBackground()
        self.navigationController?.navigationBar.tintColor = UIColor.textColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.textColor()]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.textColor()]
        self.navigationController?.setStatusBar(backgroundColor: UIColor.navigationBackground())
        self.designButton = UIBarButtonItem(title: self.designButtonTitle, style: .done, target: viewModel , action: #selector(viewModel.changeShape))
        self.navigationItem.setRightBarButton(self.designButton, animated: true)
        self.navigationItem.searchController = viewModel.searchController
    }
    
    
    
    func setupSearchBar() {
        
        viewModel.searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textColor(), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 13.0)!])
        viewModel.searchController.searchBar.searchTextField.textColor = .white
        viewModel.searchController.searchBar.searchTextField.backgroundColor = .clear
        viewModel.searchController.searchBar.searchTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        viewModel.searchController.searchBar.sizeToFit()
        viewModel.searchController.searchBar.tintColor = .white
        viewModel.searchController.hidesNavigationBarDuringPresentation = false
        viewModel.searchController.searchBar.barStyle = .default
        viewModel.searchController.dimsBackgroundDuringPresentation = false
        viewModel.searchController.searchBar.barTintColor = UIColor.textColor()
        viewModel.searchController.searchBar.isTranslucent = false
        viewModel.searchController.searchBar.isHidden = false
        
        let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.textColor(), .font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        for view in viewModel.searchController.searchBar.subviews {
            for subview in view.subviews where subview.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                subview.alpha = 0
            }
        }
    }
    
    func setFloatingButton(){
        
//*****        ??????????
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
//        Floating buttonun ekrandaki yeri ve boyutu.
        viewModel.floatingButton.frame = CGRect(x: self.view.frame.width - 65, y: UIScreen.main.bounds.height - bottomPadding! - 80, width: 56, height: 56)
        
//        Floating buttonun görseli.
        viewModel.floatingButton.setImage(UIImage(named: "upicon"), for: .normal)
        
//        Floating buttonun arkaplan rengi.
        viewModel.floatingButton.backgroundColor = UIColor(red: 105/255, green: 74/255, blue: 254/255, alpha: 1.0)
        viewModel.floatingButton.clipsToBounds = true
        
//        Floating buttonun köşe yarıçapı.
        viewModel.floatingButton.layer.cornerRadius = 28
        
//        Floating buttonun aksiyonu.
        viewModel.floatingButton.addTarget(self, action: #selector(self.upButtonTapped(_:)), for: .touchUpInside)
        
//        View'e ekledik.
        view.addSubview(viewModel.floatingButton)
    }
    
    @objc func upButtonTapped(_ sender: UIButton) {
        viewModel.collectionView.setContentOffset(.zero, animated: true)
        viewModel.floatingButton.isHidden = true
    }

}

extension MarvelViewController: MarvelViewModelDelegate {
    
    func collectionViewDesign(title: String) {
        self.designButtonTitle = title
        self.setupNavigationController()
    }
        
    func selectedItem(marvelModel: ResultModel) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController" ) as? DetailsViewController {
            
            viewController.viewModel.marvelId = marvelModel.id ?? 00
            viewController.viewModel.detailModel = marvelModel
            viewController.setupNavigationButton()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func changedStatus(status: BaseViewController.RequestStatus) {
        
        switch status {
        case .completed(let error):
            if error != nil {
                print("error")
            }
            else {
                viewModel.collectionView.reloadData()
                viewModel.floatingButton.isHidden = true

            }
        default: break
        }
    }    
}
