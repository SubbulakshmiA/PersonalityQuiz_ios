//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by user243757 on 10/5/23.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLable: UILabel!
    
    
    @IBOutlet weak var singleAnswerStackView: UIStackView!
    
    @IBOutlet weak var singleBtn1: UIButton!
    
    @IBOutlet weak var singleBtn2: UIButton!
    
    
    @IBOutlet weak var singleBtn3: UIButton!
    
    @IBOutlet weak var singleBtn4: UIButton!
    
    
    @IBOutlet weak var multipleAnswerStackView: UIStackView!
    
    @IBOutlet weak var multipleLable1: UILabel!
    
    @IBOutlet weak var multipleLable2: UILabel!
    
    
    @IBOutlet weak var multipleLable3: UILabel!
    
    
    @IBOutlet weak var multipleLable4: UILabel!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedlable1: UILabel!
    
    @IBOutlet weak var rangedLable2: UILabel!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var multipleSwitch1: UISwitch!
    
    
    @IBOutlet weak var multipleSwitch2: UISwitch!
    
    @IBOutlet weak var multipleSwitch3: UISwitch!
    
    
    @IBOutlet weak var multipleSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    
    
    var questionIndex = 0
    var answersChosen :[Answer] = []
    
    
    var questions :[Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [Answer(text: "steak", type:.dog),
                           Answer(text: "Fish", type: .cat),
                           Answer(text: "Carrots", type:.rabbit),
                           Answer(text: "Corn", type: .turtle)]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [Answer(text: "swimming", type: AnswerTYpe.turtle),
                           Answer(text: "cuddling", type: AnswerTYpe.rabbit),
                           Answer(text: "sleeping", type: AnswerTYpe.cat),
                           Answer(text: "eating", type: AnswerTYpe.dog)]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [Answer(text: "I barely notice them", type: AnswerTYpe.turtle),
                           Answer(text: "I love them", type: AnswerTYpe.dog),
                           Answer(text: "I get a little nervous", type: AnswerTYpe.rabbit),
                           Answer(text: "I dislike them", type: AnswerTYpe.cat)])
                          ]

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func singleSVBtnPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionIndex].answers
       
        switch sender{
        case singleBtn1:
            answersChosen.append(currentAnswer[0])
        case singleBtn2:
            answersChosen.append(currentAnswer[1])
        case singleBtn3:
            answersChosen.append(currentAnswer[2])
        case singleBtn4:
            answersChosen.append(currentAnswer[3])
        default :
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleSVBtnPressed() {
        let currentAnswer = questions[questionIndex].answers
        
        if multipleSwitch1.isOn{
            answersChosen.append(currentAnswer[0])
        }
        if multipleSwitch2.isOn{
            answersChosen.append(currentAnswer[1])
        }
        if multipleSwitch3.isOn{
            answersChosen.append(currentAnswer[2])
        }
        if multipleSwitch4.isOn{
            answersChosen.append(currentAnswer[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerBtnPressed() {
        let currentAnswer = questions[questionIndex].answers
        rangedSlider.setValue(0.5, animated: false)
        
        let index = Int(round(rangedSlider.value * Float(currentAnswer.count - 1)))
        answersChosen.append(currentAnswer[index])
        nextQuestion()
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    
    
    
    
    func nextQuestion(){
        questionIndex += 1
        if questionIndex < questions.count{
            updateUI()
        }else{
            performSegue(withIdentifier: "results", sender: nil)
        }
        
    }
    
    func updateUI(){
        singleAnswerStackView.isHidden = true
        multipleAnswerStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswer = currentQuestion.answers
        let totalProgress = Float(questionIndex)/Float(questions.count)
        
        questionLable.text = currentQuestion.text
        progressBar.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type{
        case .single:
            updateSingleStackView(using: currentAnswer)
        case .multiple:
            updateMultipleStackView(using: currentAnswer)
        case .ranged:
            updateRangedStackView(using: currentAnswer)
        }
    }
    
    func updateSingleStackView(using answers:[Answer]){
        singleAnswerStackView.isHidden = false
        singleBtn1.setTitle(answers[0].text, for: .normal)
        singleBtn2.setTitle(answers[1].text, for: .normal)
        singleBtn3.setTitle(answers[2].text, for: .normal)
        singleBtn4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStackView(using answers:[Answer]){
        multipleAnswerStackView.isHidden = false
        multipleSwitch1.isOn = false
        multipleSwitch2.isOn = false
        multipleSwitch3.isOn = false
        multipleSwitch4.isOn = false
       
        multipleLable1.text = answers[0].text
        multipleLable2.text = answers[1].text
        multipleLable3.text = answers[2].text
        multipleLable4.text = answers[3].text
    }
    func updateRangedStackView(using answers:[Answer]){
        rangedStackView.isHidden = false
        rangedlable1.text = answers.first?.text
        rangedLable2.text = answers.last?.text
        
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
