//
//  MovieDetailVC.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 28/07/24.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var releaseYearLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLbl: UILabel!
    
    var viewModel: MovieDetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
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
                self?.headerView.isHidden = false
                self?.tableView.isHidden = false
                self?.errorView.isHidden = true
                self?.updateView()
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.movieDetailsNotFetched = { [weak self] errorMessage in
            //hide table and show error
            DispatchQueue.main.async {
                self?.headerView.isHidden = true
                self?.tableView.isHidden = true
                self?.errorView.isHidden = false
                self?.errorLbl.text = errorMessage
            }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let posterImage = image {
                    self?.posterImgView.image = posterImage
                } else {
                    // set placeholder img
                    self?.posterImgView.image = UIImage(systemName: "popcorn")
                }
            }
        }
    }
    
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.detailsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableCell", for: indexPath) as? MovieDetailTableCell
        cell?.model = viewModel?.detailsList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
}
