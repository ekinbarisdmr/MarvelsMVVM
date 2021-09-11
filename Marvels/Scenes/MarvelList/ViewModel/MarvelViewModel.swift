//
//  MarvelListViewModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import UIKit

protocol MarvelViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
    func selectedItem(marvelModel: ResultModel)
    func collectionViewDesign(title: String)
}

class MarvelListViewModel: NSObject {
    
    @IBOutlet var collectionView: UICollectionView!
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let searchController = UISearchController(searchResultsController: nil)
    var marvelList = [ResultModel]()
    var searchResults = [ResultModel]()
    var delegate: MarvelViewModelDelegate?
    var likeArray = [LikeModel]()
    var itemCount = 0
    var isListDesign = true
    let floatingButton = UIButton()

    
    
    func fetchMarvels() {
        
        API.sharedManager.getMarvels(itemCount: self.itemCount) { [self] (response) in
            if let marvelList = response.data?.results {
                self.marvelList = marvelList
                self.delegate?.changedStatus(status: .completed(nil))
            }
            itemCount += 20
        } errorHandler: { (error) in
            print(error)
        }
        
    }
    //    MARK: SetupCollectionView
    
    func setupCollectionView() {
        
        collectionView.register(UINib(nibName: "MarvelListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "marvelListCell")
        collectionView.register(UINib(nibName: "MarvelGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "marvelGridCell")
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchBar.delegate = self
        collectionView.reloadData()
        
    }
    
    @objc func changeShape(sender: UIBarButtonItem) {
        if isListDesign {
            self.isListDesign = false
            self.delegate?.collectionViewDesign(title: "Grid")
        }
        else {
            self.isListDesign = true
            self.delegate?.collectionViewDesign(title: "List")
        }
        self.setupCollectionView()
        self.collectionView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            self.fetchMarvels()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        if currentOffset > 120 {
            floatingButton.isHidden = false
        }
        else {
            floatingButton.isHidden = true
        }
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension MarvelListViewModel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.isListDesign {
            return CGSize(width: (self.collectionView.frame.size.width - 30) , height: (self.collectionView.frame.size.height - 20) / 5)
        }
        else {
            return CGSize(width: (self.collectionView.frame.size.width - 30) / 2, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


//MARK: UICollectionViewDataSource

extension MarvelListViewModel: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchController.isActive == true && searchController.searchBar.text != "" {
            return searchResults.count
        }
        else {
            return marvelList.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.isListDesign {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvelListCell", for: indexPath) as! MarvelListCollectionViewCell
            
            var marvelListCellModel = MarvelListCellModel()
            
            if searchController.isActive == true && searchController.searchBar.text != "" {
                marvelListCellModel = MarvelListCellModel(resultModel: searchResults[indexPath.row])
            }
            else {
                
                marvelListCellModel = MarvelListCellModel(resultModel: marvelList[indexPath.row])
            }
            
            cell.dataSource = marvelListCellModel
            cell.reloadData()
            cell.likeImage.isHidden = true
            
            if searchController.isActive == true && searchController.searchBar.text != "" {
                for index in 0..<likeArray.count {
                    if let index = searchResults.firstIndex(where: {$0.id == Int(likeArray[index].characterId)}) {
                        if indexPath.row == index {
                            cell.likeImage.isHidden = false
                        }
                    }
                }
            }
            else {
                for index in 0..<likeArray.count {
                    if let index = marvelList.firstIndex(where: {$0.id == Int(likeArray[index].characterId)}) {
                        if indexPath.row == index {
                            cell.likeImage.isHidden = false
                        }
                    }
                }
            }
            return cell
            
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvelGridCell", for: indexPath) as! MarvelGridCollectionViewCell
            
            var marvelGridCellModel = MarvelGridCellModel()
            
            if searchController.isActive == true && searchController.searchBar.text != "" {
                marvelGridCellModel = MarvelGridCellModel(resultModel: searchResults[indexPath.row])
            }
            else {
                marvelGridCellModel = MarvelGridCellModel(resultModel: marvelList[indexPath.row])
            }
            
            cell.dataSource = marvelGridCellModel
            cell.reloadData()
            cell.likeImage.isHidden = true
            
            if searchController.isActive == true && searchController.searchBar.text != "" {
                for index in 0..<likeArray.count {
                    if let index = searchResults.firstIndex(where: {$0.id == Int(likeArray[index].characterId)}) {
                        if indexPath.row == index {
                            cell.likeImage.isHidden = false
                        }
                    }
                }
            }
            else {
                for index in 0..<likeArray.count {
                    if let index = marvelList.firstIndex(where: {$0.id == Int(likeArray[index].characterId)}) {
                        if indexPath.row == index {
                            cell.likeImage.isHidden = false
                        }
                    }
                }
            }
            return cell
        }
    }
}

//MARK: UICollectionViewDelagete

extension MarvelListViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchController.isActive == true && searchController.searchBar.text != "" {
            self.delegate?.selectedItem(marvelModel: searchResults[indexPath.row])
        }
        else {
            self.delegate?.selectedItem(marvelModel: marvelList[indexPath.row])
        }
    }
}

//MARK: UISearchBarDelegate

extension MarvelListViewModel: UISearchBarDelegate {
     
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchResults = marvelList.filter({ (ResultModel) -> Bool in
            let match = ResultModel.name?.range(of: searchText, options: .caseInsensitive)
            return (match != nil)
        })
        collectionView.reloadData()
    }
}





