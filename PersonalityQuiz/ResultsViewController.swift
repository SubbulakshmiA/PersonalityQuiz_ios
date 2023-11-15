//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by user243757 on 10/5/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var resultsLable: UILabel!
    
    
    @IBOutlet weak var resultDescriptionLable: UILabel!
   
    var responses :[Answer]
        
    init?(coder:NSCoder, responses :[Answer]){
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
        // Do any additional setup after loading the view.
    }
    
    func calculatePersonalityResult(){
        let frequencyOfAnswers = responses.reduce(into: [:]){
            (counts,answer) in
            counts[answer.type, default: 0] += 1
        }
        let mostCommonAnswer = frequencyOfAnswers.sorted{
            $0.1 > $1.1}.first!.key
        
        resultsLable.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDescriptionLable.text = "\(mostCommonAnswer.definition)"
        
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
