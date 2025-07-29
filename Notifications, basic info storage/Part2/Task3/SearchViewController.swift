//
//  SearchViewController.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 29/07/2025.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let searchField = UITextField()
    private let searchButton = UIButton(type: .system)
    private let tableView = UITableView()
    
    private var searchHistory: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        loadSearchHistory()
    }
    
    private func setupUI() {
        searchField.placeholder = "Enter search term"
        searchField.borderStyle = .roundedRect
        searchField.tintColor = .systemBlue
        searchField.textColor = .label
        searchField.autocapitalizationType = .none
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let stack = UIStackView(arrangedSubviews: [searchField, searchButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func handleSearch() {
        guard let text = searchField.text, !text.isEmpty else { return }
        addSearchTerm(text)
        searchField.text = ""
    }
    
    private func addSearchTerm(_ term: String) {
        loadSearchHistory()
        
        searchHistory.removeAll { $0.lowercased() == term.lowercased() }
        
        searchHistory.insert(term, at: 0)
        
        if searchHistory.count > 5 {
            searchHistory = Array(searchHistory.prefix(5))
        }
        
        UserDefaults.standard.set(searchHistory, forKey: SearchDefaults.searchHistory)
    }
    
    private func loadSearchHistory() {
        searchHistory = UserDefaults.standard.stringArray(forKey: SearchDefaults.searchHistory) ?? []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchHistory[indexPath.row]
        return cell
    }
}
