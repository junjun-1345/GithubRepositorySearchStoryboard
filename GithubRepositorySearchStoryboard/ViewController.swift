//
//  ViewController.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // 読み取り専用のset
    private(set) var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    // ユーザー情報を取得
        func fetchUser(query: String, completion: @escaping (Result<[User]>) -> ()) {
            let request = SearchUsersRequest(query: query)
            
            Session().send(request) { result in
                switch result {
                case .success(let response):
                    completion(.success(response.items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
}

extension ViewController: UISearchBarDelegate {
    // 編集開始時の処理
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // キャンセルボタンを表示
        searchBar.showsCancelButton = true
        
        return true
    }
    
    // キャンセルボタン選択時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // キャンセルボタンを非表示に変更
        searchBar.showsCancelButton = false
        // キーボードを下げる
        searchBar.resignFirstResponder()
    }
    
    // 検索実行時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        guard !query.isEmpty else { return }
        
        fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                // TODO: Error Handling
                ()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    // セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(user: users[indexPath.row])
        
        return cell
    }
}
