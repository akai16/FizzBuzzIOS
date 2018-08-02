//
//  LeaderBoardViewController.swift
//  FizzBuzzJoguinho
//
//  Created by Treinamento on 01/08/18.
//  Copyright © 2018 somaisumesquisito. All rights reserved.
//

import UIKit
import CoreData

class LeaderBoardViewController: UIViewController {

    //MARK : - Variables
    var players: [PlayerMO] = []
    var DBManagerHelper : DBManager = DBManager.getInstance()
    
    
    //MARK : - Outlets
    @IBOutlet weak var playerTableView: UITableView!
    
    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.playerTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchPlayers()
        self.playerTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK : - ViewFunctions
    func fetchPlayers() {
        let fetchRequest: NSFetchRequest<PlayerMO> = PlayerMO.fetchRequest()
        let nsSort = NSSortDescriptor(key: "score", ascending: false)
        
        fetchRequest.sortDescriptors = [nsSort]
        
        do {
            try self.players = (DBManagerHelper.managedContext?.fetch(fetchRequest))!
        } catch let error as NSError {
            print("Erro ao buscar lista de jogadores \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.deleteFromDB(player: self.players[indexPath.row])
            self.players.remove(at: indexPath.row)
            self.playerTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteFromDB(player: PlayerMO) {
        self.DBManagerHelper.managedContext?.delete(player)
        self.DBManagerHelper.appDelegate?.saveContext()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tabBarItem = UITabBarItem(title: "LeaderBoard", image: #imageLiteral(resourceName: "leaderboard"), tag: 2)
    }
    
}

//MARK : - Extension
extension LeaderBoardViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerCell"
        
        guard let cell = self.playerTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerTableViewCell else {
            fatalError("Erro ao montar lista de jogadores")
        }
        
        let currentPlayer = self.players[indexPath.row]
        
        cell.nome.text = currentPlayer.nome
        cell.score.text = String(currentPlayer.score)
        cell.foto.image = UIImage(data: currentPlayer.foto!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1    
    }
    
}
