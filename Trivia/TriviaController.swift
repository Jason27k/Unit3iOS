//
//  TriviaController.swift
//  Trivia
//
//  Created by Jason Morales on 10/3/23.
//
import UIKit

let firstQuestion = Question(titleFill: "Question 1/3", categoryFill: "Space", questionFull: "What was the first spaceship to carry human passengers?", first: "Vostok 1", second: "Apollo 11", third: "Sputnik 1", fourth: "Proton", correct: 1)
let secondQuestion = Question(titleFill: "Question 2/3", categoryFill: "Chemistry", questionFull: "What chemical causes the burning taste after eating chillies?", first: "Piperine", second: "Capsicum", third: "Capsaicin", fourth: "Cayenne", correct: 3)
let thirdQuestion = Question(titleFill: "Question 3/3", categoryFill: "Biology", questionFull: "What is the most common element in the human body?", first: "Carbon", second: "Oxygen", third: "Calcium", fourth: "Hydrogen", correct: 2)
var questions = [firstQuestion, secondQuestion, thirdQuestion]
var currentIndex = 0
var answeredCorrect = 0;

class TriviaController : UIViewController {
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var categoryLabel: UILabel?
    @IBOutlet var questionLabel: UILabel?
    @IBOutlet var firstOption: UIButton?
    @IBOutlet var secondOption: UIButton?
    @IBOutlet var thirdOption: UIButton?
    @IBOutlet var fourthOption: UIButton?
    
    
    
    override func viewDidLoad() {
        prepPage()
        super.viewDidLoad()
    }
    
    func prepPage() {
        let f = questions[currentIndex]
        titleLabel?.text = f.titleFill
        categoryLabel?.text = f.categoryFill
        questionLabel?.text = f.questionFull
        firstOption?.setTitle(f.first, for: .normal)
        secondOption?.setTitle(f.second, for: .normal)
        thirdOption?.setTitle(f.third, for: .normal)
        fourthOption?.setTitle(f.fourth, for: .normal)
    }
    
    @IBAction func tappedFirst() {
        if questions[currentIndex].correct == 1 {
            answeredCorrect += 1
        }
        moveNext();
    }
    
    @IBAction func tappedSecond() {
        if questions[currentIndex].correct == 2 {
            answeredCorrect += 1
        }
        moveNext();
    }
    
    @IBAction func tappedThird() {
        if questions[currentIndex].correct == 3 {
            answeredCorrect += 1
        }
        moveNext();
    }
    
    @IBAction func tappedFourth() {
        if questions[currentIndex].correct == 4 {
            answeredCorrect += 1
        }
        moveNext();
    }
    
    func moveNext() {
        if currentIndex < 2 {
            currentIndex += 1
            prepPage()
        }
        else {
            let alertController = UIAlertController(title: "Quiz Completed", message: "You answered \(answeredCorrect) out of 3 questions correctly.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Restart", style: .default) { (_) in
                currentIndex = 0
                answeredCorrect = 0
                self.prepPage()
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
