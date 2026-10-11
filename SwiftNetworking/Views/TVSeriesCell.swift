//
//  TVSeriesCell.swift
//  SwiftNetworking
//
//  Created by Erik Valencia Cardona on 9/10/26.
//

import UIKit

final class TVSeriesCell: UITableViewCell {
    static let reuseIdentifier = "TVSeriesCell"
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    
    private var representedSeriesID: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        representedSeriesID = nil
        posterImageView.image = nil
        nameLabel.text = nil
        ratingLabel.text = nil
        overviewLabel.text = nil
    }
    
    func configure(with series: TVSeries) {
        assert(posterImageView != nil, "posterImageView no está conectado")
            assert(nameLabel != nil, "nameLabel no está conectado")
            assert(ratingLabel != nil, "ratingLabel no está conectado")
            assert(overviewLabel != nil, "overviewLabel no está conectado")
        
        representedSeriesID = series.id
        
        nameLabel.text = series.name
        ratingLabel.text = String(
            format: "★ %.1f / 10",
            series.voteAverage
        )
        overviewLabel.text = series.overview
        
        loadPoster(from: series.posterPath, for: series.id)
        
    }
    
    private func loadPoster(from path: String?, for seriesID: Int) {
        guard
            let path = path,
            let url = URL(
                string: "https://image.tmdb.org/t/p/w500\(path)"
            )
        else {
            posterImageView.image = UIImage(systemName: "photo")
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            [weak self] data, response, error in
            
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let data = data,
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                guard self?.representedSeriesID == seriesID else {
                    return
                }
                
                self?.posterImageView.image = image
            }
        }.resume()
    }
}
