//
//  TriviaController.swift
//  Trivia
//
//  Created by Jason Morales on 10/3/23.
//
import UIKit

extension String {
    func decodingHTMLEntities() -> String {
        guard let data = self.data(using: .utf8) else { return self }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        } else {
            return self
        }
    }
}

class TriviaController : UIViewController {
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var categoryLabel: UILabel?
    @IBOutlet var questionLabel: UILabel?
    @IBOutlet var firstOption: UIButton?
    @IBOutlet var secondOption: UIButton?
    @IBOutlet var thirdOption: UIButton?
    @IBOutlet var fourthOption: UIButton?
    
    var questions: [Question] = []
    var currentIndex = 0
    var answeredCorrect = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTriviaQuestions()
    }
    
    func fetchTriviaQuestions() {
        TriviaService.fetchTrivia {fetchedQuestions in
            self.questions = fetchedQuestions
                DispatchQueue.main.async {
                    self.prepPage()
                }
            }
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        if let selectedAnswer = sender.title(for: .normal) {
            if questions[currentIndex].correct == selectedAnswer {
                answeredCorrect += 1
            }
        }
        moveNext()
    }
    
    func moveNext() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            prepPage()
        } else {
            showQuizCompletionAlert()
        }
    }

    func prepPage() {
        if currentIndex < questions.count {
            let question = questions[currentIndex]
            var answerOptions = question.answerList
            answerOptions.append(question.correct)
            answerOptions.shuffle()
            titleLabel?.text = "Question: \(currentIndex + 1)/\(questions.count)"
            categoryLabel?.text = question.categoryFill
            questionLabel?.text = question.questionFull.decodingHTMLEntities()
            if question.answerList.count == 1 {
                firstOption?.isHidden = true
                fourthOption?.isHidden = true
            } 
            for (index, option) in [secondOption, thirdOption, fourthOption, firstOption].enumerated() {
                if !(option?.isHidden ?? true) && index < answerOptions.count{
                    option?.setTitle(answerOptions[index].decodingHTMLEntities(), for: .normal)
                }
            }
        } else {
            showQuizCompletionAlert()
        }
    }

    func showQuizCompletionAlert() {
        let alertController = UIAlertController(title: "Quiz Completed", message: "You answered \(answeredCorrect) out of \(questions.count) questions correctly.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Restart", style: .default) { (_) in
            self.currentIndex = 0
            self.answeredCorrect = 0
            self.fetchTriviaQuestions()
            self.prepPage()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
