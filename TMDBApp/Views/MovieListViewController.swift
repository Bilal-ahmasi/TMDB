//
//  MovieListViewController.swift
//  TMDBApp
//
//  Created by Bilal Ahmad on 12/12/2024.
//
import UIKit
import Combine

class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tblView = UITableView()
        tblView.frame = view.bounds
        tblView.delegate = self
        tblView.dataSource = self
        tblView.backgroundColor = .white
        tblView.separatorStyle = .singleLine
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tblView
    }()

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchPopularMovies()
    }

    private func setupUI() {
        title = "Popular Movies"
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message: message)
            }
            .store(in: &cancellables)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        present(alert, animated: true)
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.contentView.backgroundColor = .white
        cell.textLabel?.textColor = .black
        let movie = viewModel.movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        let detailViewModel = MovieDetailViewModel(movieID: movie.id, repository: viewModel.repository)
        let detailVC = MovieDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
