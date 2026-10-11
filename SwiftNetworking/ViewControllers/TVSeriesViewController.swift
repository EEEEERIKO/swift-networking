//
//  TVSeriesViewController.swift
//  SwiftNetworking
//
//  Created by Erik Valencia Cardona on 9/10/26.
//

import UIKit

final class TVSeriesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let tvService = TVService()
    private var tvSeries: [TVSeries] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Rated TV Shows"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 160
        tableView.estimatedRowHeight = 160
        
        fetchTVSeries()
    }
    
    
    private func fetchTVSeries() {
        tvService.fetchTopRatedTVShows { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let series):
                    self.tvSeries = series
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: NetworkError) {
        let message: String
        
        switch error {
        case .invalidURL:
            message = "The server returned an invalid response"
            
        case .invalidResponse:
            message = "The server retunred an invalid response"
            
        case .httpError(let statusCode):
            message = "The server returned HTTP status \(statusCode)"
            
        case .noData:
            message = "No data was received from the server"
            
        case .decodingError:
            message = "THe received data could not be decoded"
            
        case .requestFailed(let underlyingError):
            message = underlyingError.localizedDescription
        }
        
        let alert = UIAlertController(
            title: "Unable to Load TV Shows",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )
        
        present(alert, animated: true)
        
   
    }
}


extension TVSeriesViewController: UITableViewDataSource {
    
    func tableView(
        _ tablaView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        tvSeries.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TVSeriesCell.reuseIdentifier,
            for: indexPath
        )
        
        guard let tvCell = cell as? TVSeriesCell else {
            fatalError("Could not cast cell to TVSeriesCell")
        }
        
        let series = tvSeries[indexPath.row]
        tvCell.configure(with: series)
        
        return tvCell
    }
    
}

extension TVSeriesViewController: UITableViewDelegate {
    
    func tableView(
        _tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
