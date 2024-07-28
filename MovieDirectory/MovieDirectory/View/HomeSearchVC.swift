//
//  HomeSearchVC.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 27/07/24.
//

import UIKit

class HomeSearchVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    private let searchViewModel: HomeViewModel = HomeViewModel()
    private var previousSearch: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaults()
    }
    
    private func setupDefaults() {
        textField.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        handleCallBack()
        setupCollectionView()
    }
    
    private func handleCallBack() {
        searchViewModel.moviesFetched = {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
        
        searchViewModel.moviesNotFetched = { error in
            // show error if movie does not exist or network fails 
        }
    }
    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView?.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        textField.resignFirstResponder()
        if let searchFieldText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if previousSearch == searchFieldText {
                return
            }
            
            previousSearch = searchFieldText
            searchViewModel.model = nil
            movieCollectionView.reloadData()
            searchViewModel.fetchData(keyWord: searchFieldText)
        }
    }
    
}

extension HomeSearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchViewModel.model?.search?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let list = self.searchViewModel.model?.search, list.count > 0 else {
            return UICollectionViewCell()
        }

        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        cell?.viewModel = list[indexPath.row]

        // when the last cell becomes visible, make another request to fetch more data
        if let count = searchViewModel.model?.search?.count, indexPath.row == count - 1 {
            searchViewModel.fetchData(keyWord: textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        
        return CGSize(width: width - 32, height: 182)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movieCell = movieCollectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell,
              let movieId = movieCell.viewModel?.imdbId 
        else { return }
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as? MovieDetailVC {
            let vm = MovieDetailViewModel()
            detailVC.viewModel = vm
            vm.fetchDetailsById(id: movieId)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
}

extension HomeSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchBtn.sendActions(for: .touchUpInside)
        return true
    }
}
