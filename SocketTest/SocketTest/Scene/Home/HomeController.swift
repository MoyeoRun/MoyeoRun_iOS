//
//  HomeController.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet var roomTableView: UITableView!
    
    var roomItems: [Room] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRoom()
    }
    
    func searchRoom() {
        let request: RoomListRequest = RoomListRequest(accessToken: UserDefaults.standard.string(forKey: "accessToken")!)
        let repository: RoomRepository = RoomRepository()
        
        repository.inquiryRoomList(request: request) { result in
            switch result {
            case .success(let response):
                self.roomItems = response.rooms
                self.roomTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func popUp(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "makeRoom")
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true)
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.id, for: indexPath) as? RoomTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(data: roomItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Room", bundle: nil)
        let roomController = storyboard.instantiateViewController(withIdentifier: "room") as? RoomController
        roomController?.setRoomId(id: roomItems[indexPath.row].roomId)
        roomController?.modalPresentationStyle = .overFullScreen
        self.present(roomController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
