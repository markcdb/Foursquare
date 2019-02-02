//
//  ViewController.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 30/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class LocationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LocationVM!
    
    let identifiers = [Cells.locationCell,
                       Cells.loaderCell,
                       Cells.permissionCell]
    
}

//MARK: - Overrides
extension LocationVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = Titles.nearby
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel = LocationVM(repository: Repository.shared,
                               delegate: self)
        
        for identifier in identifiers {
            tableView.register(UINib(nibName: identifier,
                                     bundle: nil),
                               forCellReuseIdentifier: identifier)
        }
        
        viewModel.loadDefaultLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let locationDetailsVC = segue.destination as? LocationDetailsVC,
            let indexPath = sender as? IndexPath,
            let venue = viewModel.getVenue(at: indexPath.row) {
            
            let vm = LocationDetailsVM(repository: Repository.shared,
                                       venue: venue)
            locationDetailsVC.viewModel = vm
        }
    }
}

//MARK: - Custom methods
extension LocationVC {
    
    private func createLocationCell(tableView: UITableView,
                                    indexPath: IndexPath) -> LocationCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.locationCell,
                                                 for: indexPath) as! LocationCell
        
        cell.titleLabel?.text = viewModel.getVenueName(at: indexPath.row)
        cell.subTitleLabel?.text = viewModel.getVenueDistance(at: indexPath.row)
        
        return cell
    }
    
    private func createLoaderCell(tableView: UITableView,
                                  indexPath: IndexPath) -> LoaderCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.loaderCell,
                                                 for: indexPath) as! LoaderCell
        
        cell.loadingIndicator.startAnimating()
        
        return cell
    }
    
    private func createPermissionCell(tableView: UITableView,
                                      indexPath: IndexPath) -> PermissionCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.permissionCell,
                                                 for: indexPath) as! PermissionCell
        
        cell.delegate = self
        
        return cell
    }
}

//MARK: - LocationVM Delegate
extension LocationVC: LocationVMDelegate {
    func locationVM(_ vm: LocationVM,
                    viewStateChanged state: ViewState,
                    message msg: String?) {
        
        if state == .loading("") {
            tableView.reloadSections([0], with: .automatic)
        }
        
        if state == .success("") {
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [IndexPath(row: 0, section: 0)],
                                     with: .bottom)
                tableView.reloadSections([0], with: .automatic)
            })
        }
    }
    
    func locationVmLocationUpdateFailed(_ vm: LocationVM) {
        
        tableView.reloadData()
    }
}

// Mark: - TableView delegate and datasource
extension LocationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if viewModel.getLocationAuthorization() == false {
            let bar = navigationController?.navigationBar.frame.height ?? 0.0
            return view.frame.height - bar
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.getState() == .loading("") {
            return 1
        }
        
        if viewModel.getLocationAuthorization() == false {
            return 1
        }
        
        return viewModel.getVenuesCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell! = UITableViewCell()
        let authorized = viewModel.getLocationAuthorization()
        
        if viewModel.getState() == .loading(""),
            authorized == true {
            cell = createLoaderCell(tableView: tableView,
                                    indexPath: indexPath)
            cell.selectionStyle = .none
        } else if viewModel.getVenuesCount() > 0,
            authorized == true  {
            cell = createLocationCell(tableView: tableView,
                                      indexPath: indexPath)
        } else if authorized == false {
            cell = createPermissionCell(tableView: tableView,
                                        indexPath: indexPath)
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if viewModel.getVenuesCount() > 0 {
            
            performSegue(withIdentifier: Segues.locationDetails,
                         sender: indexPath)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LocationVC: PermissionCellDelegate {
    
    func didTapPermissionButton(_ sender: UIButton) {
        //Go to settings
        guard let settings = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settings)
    }
}
