//
//  ListViewController.swift
//  Remote_state
//
//  Created by Apple on 30/04/22.
//

import UIKit
import SwiftyJSON

class ListViewController: UIViewController {

    @IBOutlet weak var listAndMapButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var truckData = JSON()
    let interval = 1585018575000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full

        let formattedString = formatter.string(from: TimeInterval(interval))!
        print(formattedString)
    }

}


// MARK:- Initial Functions

extension ListViewController {
    
    private func initialLoads(){
        setText()
        setColor()
        setFont()
        setDelegate()
        AddTarget()
        initialAPI()
    }
    
    private func setText(){
        
    }
    
    private func setColor(){
        
    }
    
    private func setFont(){
        
    }
    
    private func setDelegate() {
        listTableView.register(UINib(nibName: "TruckListCell", bundle: .main), forCellReuseIdentifier: "TruckListCell")
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        listTableView.backgroundColor = .clear
        
    }
    private func AddTarget(){
        listAndMapButton.addTarget(self, action: #selector(listAndMapAction), for: .touchUpInside)
    }
    
    private func initialAPI(){
        
    }
    
    @objc func listAndMapAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - TableView && Delegates

extension ListViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckData["data"].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckListCell", for: indexPath) as! TruckListCell
        cell.truckName.text = truckData["data"][indexPath.row]["truckNumber"].stringValue
//        cell.idelTime.text = formateDate(date: truckData["data"][indexPath.row]["stopStartTime"].stringValue)
        cell.truckSpeed.text = truckData["data"][indexPath.row]["speed"].stringValue
//        cell.timeStamp.text = formateDate(date: truckData["data"][indexPath.row]["createTime"].stringValue)
        cell.selectionStyle = .none
        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 60
    }
}

//MARK: Timestamp fomater
func formateDate(date: String?) -> String? {
    
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: nullStringToEmpty(string: date))!
    dateFormatter.dateFormat = "dd-MM-yyyy" //hh:mm:ss"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
    print("EXACT_DATE : \(dateString)")
    
    return nullStringToEmpty(string: dateString)
}

public func nullStringToEmpty(string: String?) -> String {
    
    if string == nil {
        return ""
    }
    else {
        return string!
    }
}

//MARK: Timestamp fomater
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

