//
//  LocationDetailsVC.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 02/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class LocationDetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cells = [[Cells.locationTitleCell: Cells.locationTitleCell],
                 [Cells.locationDetailsCell: Cells.locationDetailsCell],
                 [Cells.locationDetailsCell: Cells.locationDetailsCell],
                 [Cells.locationDetailsCell: Cells.locationDetailsCell]]
    
    var viewModel: LocationDetailsVM!
}

//MARK: - Overrides
extension LocationDetailsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        for cell in cells {
            let nib = cell.keys.first ?? ""
            let identifier = cell.values.first ?? ""
            tableView.register(UINib(nibName: nib,
                                     bundle: nil),
                               forCellReuseIdentifier: identifier)
        }
        
        tableView.reloadData()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

//MARK: - Custom methods
extension LocationDetailsVC {
    
    func createLocationDetailsCell(_ tableView: UITableView,
                                   indexPath: IndexPath) -> UITableViewCell? {
        guard let title = viewModel.getValueAt(indexPath.row)?.keys,
            let subtitle = viewModel.getValueAt(indexPath.row)?.values else { return nil }
        
        let identifier = cells[indexPath.row].values.first ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as! LocationDetailsCell
        
        cell.titleLabel?.text = title.first
        cell.subTitleLabel?.text = subtitle.first as? String
        
        return cell
    }
}

//MARK: - Tableview delegate and datasource
extension LocationDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = createLocationDetailsCell(tableView,
                                                indexPath: indexPath) {
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
}
