//
//  MovieDetailVC.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 28/07/24.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var releaseYearLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieDetailViewModel?
    var detailsList: [DetailItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaults()
    }

    private func setupDefaults() {
        self.navigationController?.navigationBar.isHidden = false
        handleCallBack()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        tableView.register(UINib(nibName: "MovieDetailTableCell", bundle: nil), forCellReuseIdentifier: "MovieDetailTableCell")
    }
    
    private func handleCallBack() {
        viewModel?.movieDetailsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
                if let list = self?.viewModel?.model?.createMovieDetails() {
                    self?.detailsList = list
                }
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.movieDetailsNotFetched = { error in
            //hide table and show error
        }
    }
    
    private func updateView() {
        movieTitleLbl.text = viewModel?.model?.title
        releaseYearLbl.text = viewModel?.model?.released
        
        setImage()
    }
    
    private func setImage() {
        guard let posterString = viewModel?.model?.poster else { return }
        posterImgView.downloadImage(posterString) { [weak self] image in
            if let posterImage = image {
                DispatchQueue.main.async {
                    self?.posterImgView.image = posterImage
                }
            } else {
                // set placeholder img
                self?.posterImgView.image = UIImage(systemName: "popcorn")
            }
        }
    }
    
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableCell", for: indexPath) as? MovieDetailTableCell
        cell?.model = detailsList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
}
