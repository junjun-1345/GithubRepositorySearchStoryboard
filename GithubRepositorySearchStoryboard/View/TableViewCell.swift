//
//  TableViewCell.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var task: URLSessionTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        task?.cancel()
        task = nil
        imageView?.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configure(repository: Repository) {
        // 画像URLからユーザー画像を取得して表示
//        task = {
//            let url = repository.avatarURL
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let imageData = data else {
//                    return
//                }
//                
//                // 以下は同期処理を待ち、スコープ内は非同期処理に
//                DispatchQueue.global().async { [weak self] in
//                    guard let image = UIImage(data: imageData) else {
//                        return
//                    }
//                    
//                    // 以下スコープ内は非同期処理に
//                    DispatchQueue.main.async {
//                        self?.icon?.image = image
//                        self?.setNeedsLayout()
//                    }
//                }
//            }
//            task.resume()
//            return task
//        }()
        
        nameLabel.text = repository.login
    }
    
}
