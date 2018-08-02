//
//  ViewController.swift
//  FizzBuzzJoguinho
//
//  Created by Treinamento on 01/08/18.
//  Copyright © 2018 somaisumesquisito. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    // MARK : - Variables
    var currentNumber: Int = 1
    var gameOver = false
    var goToLeader = false
    
    //MARK : - Outlets
    @IBOutlet weak var currentNumberButton: UIButton!
    
    
    //MARK : - Actions
    @IBAction func currentNumberButtonOnClick(_ sender: Any) {
        if (!checkFizzBuzz(givenAnswer: .normal, number: self.currentNumber)) { gameWasLost() }
        else { gameNextRound() }
    }
    
    @IBAction func fizzButtonOnClick(_ sender: Any) {
        if (!checkFizzBuzz(givenAnswer: .fizz, number: self.currentNumber)) { gameWasLost() }
        else { gameNextRound() }
    }
    
    @IBAction func buzzButtonOnClick(_ sender: Any) {
        if (!checkFizzBuzz(givenAnswer: .buzz, number: self.currentNumber)) { gameWasLost() }
        else { gameNextRound() }
    }
    
    @IBAction func fizzBuzzButtonOnClick(_ sender: Any) {
        if (!checkFizzBuzz(givenAnswer: .fizzbuzz, number: self.currentNumber)) { gameWasLost() }
        else { gameNextRound() }
    }
    
    
    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameStarting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.gameOver) { self.gameStarting() }
        if (self.goToLeader) {
            self.goToLeader = false
            self.tabBarController?.selectedIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK : - GameFunctions
    func gameStarting() {
        self.currentNumber = 1
        self.gameOver = false
        self.refreshCurrentButton()
    }
    
    func gameWasLost() {
        self.gameOver = true
        self.performSegue(withIdentifier: "goToCadastro", sender: nil)
    }
    
    func gameNextRound() {
        if (self.currentNumber == 50) {
            self.gameWasWon()
        }
        else {
            self.currentNumber += 1
            self.refreshCurrentButton()
        }
    }
    
    func gameWasWon() {
        self.gameOver = true
        self.performSegue(withIdentifier: "goToCadastro", sender: nil)
    }
    
    func refreshCurrentButton() {
        self.currentNumberButton.setTitle(String(self.currentNumber - 1), for: .normal)
    }
    
    
    //MARK : - ViewFunctions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView = segue.destination as? CadastroViewController {
            nextView.score = self.currentNumber - 1
        }
    }
    
    @IBAction func unwindContinueToPlay(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindGoToLeaderBoard(segue: UIStoryboardSegue) {
        self.goToLeader = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tabBarItem = UITabBarItem(title: "Game", image: #imageLiteral(resourceName: "game"), tag: 1)
    }
    
    

}

