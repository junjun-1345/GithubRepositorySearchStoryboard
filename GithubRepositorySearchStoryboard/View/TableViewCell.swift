//
//  TableViewCell.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    private var task: URLSessionTask?
    private var repositoryURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tapGesture)
    }

    
    @objc func labelTapped() {
        if let url = repositoryURL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func configure(repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        urlLabel.text = repository.html_url.absoluteString
        repositoryURL = repository.html_url
    }
}
