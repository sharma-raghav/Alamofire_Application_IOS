//
//  ViewController.swift
//  usingAlamofire
//
//  Created by clicklabs on 01/07/20.
//  Copyright © 2020 clicklabs. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import os.log

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var image: UIImageView!
    
    var photosUrl = "https://assets.manutd.com/AssetPicker/images/0/0/10/126/687707/Legends-Profile_Cristiano-Ronaldo1523460877263.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityIndicator.startAnimating()
        // MARK: jsontypicode.com
//        AF.request(photosUrl, method: .get).validate().responseData { (response) in
//            switch response.result {
//            case .success(let value):
//                print("successfully got the json")
//                let photo = try?JSONDecoder().decode(Photo.self, from: value)
//                guard let photoUrl = URL(string: photo!.url) else { return }
//                guard let photoData = try? Data(contentsOf: photoUrl) else { return }
//                guard let photoImage = UIImage(data: photoData) else { return }
//                self.image.image = photoImage
//            case .failure:
//                print("No able to get the json data")
//                return
//            }
//        }
        // MARK: kingfisher
        let url = URL(string: photosUrl)
        let processor = DownsamplingImageProcessor(size: image.bounds.size) |>
            RoundCornerImageProcessor(cornerRadius: 20)
        image.kf.indicatorType = .activity
        image.kf.setImage(with: url, placeholder: UIImage(named: "default"), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.activityIndicator.stopAnimating()
    }


}
