//
//  DetailsViewModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import UIKit
import SDWebImage


protocol DetailsViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
    func buttonImage(isLike: Bool)
    func characterReview(url: String)
}

class DetailsViewModel: NSObject {
    
    @IBOutlet weak var tableView: UITableView!
    var marvelId = Int()
    var detailModel: ResultModel = ResultModel()
    var delegate: DetailsViewModelDelegate?
    var likeArray = [LikeModel]()
    
    
    func setupTableView() {
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.likeArray = StoreManager.shared.getLikesArray()
        

    }
    
//    func fetchMarvelModel() {
//        API.sharedManager.getDetails(characterId: self.marvelId) { (response, error) in
//            if error != nil {
//                print("Err")
//            }
//            else {
//                if let marvelModel = response {
//                    self.detailModel = marvelModel
//                }
//            }
//        }
//    }
    
    func requestLike() {
        if likeArray.contains(where: { $0.characterId == String(self.marvelId) }) {
            self.delegate?.buttonImage(isLike: true)
        }
        else {
            self.delegate?.buttonImage(isLike: false)
        }
    }
    
    @objc func likeButtonTapped(_sender: UIBarButtonItem) {
        print("tıklandı")
        if likeArray.contains(where: { $0.characterId == String(self.marvelId) }) {
            if let index = likeArray.firstIndex(where: { $0.characterId == String(self.marvelId) }) {
                likeArray.remove(at: index)
                StoreManager.shared.saveLikesArray(data: likeArray)
            }
        }
        else {
            let likedCharacter = LikeModel(characterId: String(self.marvelId))
            likeArray.append(likedCharacter)
            StoreManager.shared.saveLikesArray(data: likeArray)
            
        }
        
        if likeArray.contains(where: { $0.characterId == String(self.marvelId) }) {
            self.delegate?.buttonImage(isLike: true)
        }
        else {
            self.delegate?.buttonImage(isLike: false)
        }
    }

}

//MARK: UITableViewDataSource

extension DetailsViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailsTableViewCell
        
        var detailsCellModel = DetailsCellModel()
        detailsCellModel = DetailsCellModel(resultModel: detailModel)
        cell.dataSource = detailsCellModel 
        cell.reloadData()
        cell.review = {
            if let urlList = self.detailModel.urls {
                if let getUrl = urlList[0].url {
                    self.delegate?.characterReview(url: getUrl)
                }
            }
            
        }
        
        return cell
    }
    
}


//MARK: UITableViewDelegate

extension DetailsViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlList = detailModel.urls {
            if let url = urlList[0].url {
                self.delegate?.characterReview(url: url)
            }
        }
}
}

