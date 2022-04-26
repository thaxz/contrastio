//
//  ViewController.swift
//  CL_CONTRASTE
//
//  Created by thaxz on 24/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var red1: UITextField!
    @IBOutlet var blue1: UITextField!
    @IBOutlet var green1: UITextField!
    @IBOutlet var red2: UITextField!
    @IBOutlet var green2: UITextField!
    @IBOutlet var blue2: UITextField!
    @IBOutlet var resultadoScore: UILabel!
    @IBOutlet var viewComeco: UIView!
    @IBOutlet var nomeScore: UILabel!
    @IBOutlet var popupView: UIView!
    @IBOutlet var resultadoLetras: UILabel!
    @IBOutlet var sentenceResult: UILabel!
    @IBOutlet var imgColor1: UIImageView!
    @IBOutlet var imgColor2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgColor1.backgroundColor = UIColor (red: 247 / 255, green: 250 / 255, blue: 1, alpha: 1)
        imgColor2.backgroundColor = UIColor (red: 247 / 255, green: 250 / 255, blue: 1, alpha: 1)
    }
   
    func pickColors () -> [Double] {
        //cores rgb que o usuario digita irao aparecer na interface
        var changeRedOne: String
        changeRedOne = red1.text ?? "000"
        let valueRedOneInt: Double = Double(changeRedOne) ?? 000
        let valueRedDividedOne = valueRedOneInt / 255
        
        var changeRedTwo: String
        changeRedTwo = red2.text ?? "000"
        let valueRedTwoInt: Double = Double(changeRedTwo) ?? 000
        let valueRedDividedTwo = valueRedTwoInt / 255
        
        var changeGreenOne: String
        changeGreenOne = green1.text ?? "000"
        let valueGreenOneInt: Double = Double(changeGreenOne) ?? 000
        let valueGreenDividedOne = valueGreenOneInt / 255
        
        var changeGreenTwo: String
        changeGreenTwo = green2.text ?? "000"
        let valueGreenTwoInt: Double = Double(changeGreenTwo) ?? 000
        let valueGreenDividedTwo = valueGreenTwoInt / 255
        
        var changeBlueOne: String
        changeBlueOne = blue1.text ?? "000"
        let valueBlueOneInt: Double = Double(changeBlueOne) ?? 000
        let valueBlueDividedOne = valueBlueOneInt / 255
        
        var changeBlueTwo: String
        changeBlueTwo = blue2.text ?? "000"
        let valueBlueTwoInt: Double = Double(changeBlueTwo) ?? 000
        let valueBlueDividedTwo = valueBlueTwoInt / 255
        
        imgColor1.backgroundColor = UIColor (red: valueRedDividedOne, green: valueGreenDividedOne, blue: valueBlueDividedOne, alpha: 1)
        imgColor2.backgroundColor = UIColor (red: valueRedDividedTwo, green: valueGreenDividedTwo, blue: valueBlueDividedTwo, alpha: 1)
        
        return [valueRedDividedOne, valueGreenDividedOne, valueBlueDividedOne, valueRedDividedTwo, valueGreenDividedTwo, valueBlueDividedTwo]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        //cores rgb que o usuario digita irao aparecer na uimage
        pickColors()
    }
    func individualLuminecense() -> [Double] {
        // pega os valores individuais do red, green e blue
        var redValueOne: String
        redValueOne = red1.text ?? "000"
        let redValueOneInt: Double = Double(redValueOne) ?? 000
        // transforma o string to textfield em int para poder fazer as operacoes
        var redValueTwo: String
        redValueTwo = red2.text ?? "000"
        let redValueTwoInt: Double = Double(redValueTwo) ?? 000
        // cadastrando segunda coluna do red
        var greenValueOne: String
        greenValueOne = green1.text ?? "000"
        let greenValueOneInt: Double = Double(greenValueOne) ?? 000
        // cadastrando primeira coluna do green
        var greenValueTwo: String
        greenValueTwo = green2.text ?? "000"
        let greenValueTwoInt: Double = Double(greenValueTwo) ?? 000
        // cadastrando segunda coluna do green
        var blueValueOne: String
        blueValueOne = blue1.text ?? "000"
        let blueValueOneInt: Double = Double(blueValueOne) ?? 000
        // cadastrando primeira coluna do blue
        var blueValueTwo: String
        blueValueTwo = blue2.text ?? "000"
        let blueValueTwoInt: Double = Double(blueValueTwo) ?? 000
        // cadastrando segunda coluna do blue
        //e divide por 255
        // cria novas variaveis com 3 casas depois da virgula para armazenar esse valor
        let redDividedOne = redValueOneInt / 255
        let redDividedTwo = redValueTwoInt / 255
        let greenDividedOne = greenValueOneInt / 255
        let greenDividedTwo = greenValueTwoInt / 255
        let blueDividedOne = blueValueOneInt / 255
        let blueDividedTwo = blueValueTwoInt / 255
        
        return [redDividedOne, redDividedTwo, greenDividedOne, greenDividedTwo, blueDividedOne, blueDividedTwo]

        // retorna um total de 6 variaveis
        
    }
    func individualFormula(value: Double) -> Double {
        let Y = ((value + 0.055) / 1.055)
        return pow(Y, 2.4)
        
        // pega as variaveis geradas pela func individualLuminecense e aplica cada uma na formula
        // Y = ( X + 0,055/ 1,055) ^ 2,4
    }
    func formulaGeneral() ->[Double] {
        let ilumenecenses = individualLuminecense()
        let individualFormulas = ilumenecenses.map{ilumenecense in
            return individualFormula(value: ilumenecense)
        }
        let r1 = individualFormulas[0], g1 = individualFormulas[2], b1 = individualFormulas[4]
        let r2 = individualFormulas[1], g2 = individualFormulas[3], b2 = individualFormulas[5]
        let general1 = 0.2125 * r1 + 0.7152 * g1 + 0.0722 * b1
        let general2 = 0.2125 * r2 + 0.7152 * g2 + 0.0722 * b2
        return [general1, general2]
        // pega as variaveis da individualFormula e aplica a formula
        // Z = 0.2125 . r31 + 0.7152 . g31 + 0.0722 . b31
        // para cada grupo
        // retorna duas variaveis
    }
    func calculateRatio() -> Double {
        let generals = formulaGeneral()
        let l1 = generals[0], l2 = generals[1]
        let result = (l1 + 0.05) / (l2 + 0.05)
   //comecei aqui
        var lettersResult: String = ""
        var wordResult: String = ""
        var textResult: String = ""
        let resultString: String = String(format: "%.2f", result)
        
        switch result {
        case 0..<3.5:
            lettersResult = "   - FF"
            wordResult = "failed"
            textResult = "According to the web accessibility guidelines, being FF ranked means that there is not adequate contrast for people to see it."
        case 3.5..<4.5:
            lettersResult = "  - A"
            wordResult = "minimum"
            textResult = "According to the web accessibility guidelines, being A ranked means that there is adequate contrast for people who doesn't have visual impairments to see it."
        case 4.5..<7:
            lettersResult = "   - AA"
            wordResult = "enhanced"
            textResult = "According to the web accessibility guidelines, being AA ranked means that there is adequate contrast for people with minimum visual impairments to see it."
        case 7..<23:
            lettersResult = "      - AAA"
            wordResult = "maximum"
            textResult = "According to the web accessibility guidelines, being AAA ranked means that there is adequate contrast for people with visual impairments to see it."
        default:
            lettersResult = "   - FF"
            wordResult = "failed"
            textResult = "According to the web accessibility guidelines, being FF ranked means that there is not adequate contrast for people to see it."
        }
        resultadoLetras.text = lettersResult
        nomeScore.text = wordResult
        resultadoScore.text = resultString
        sentenceResult.text = textResult
        
        return result
        // pega as duas variaveis da formulaGeneral e aplica a formula
        // l1 + 0,05 / l2 + 0,05 = RC
        // retorna uma variavel RESULT
    }
    @IBAction func tryAgain(_ sender: Any) {
        //esconder o pop-up
        popupView.isHidden = true
        //exibir view de inicio
        viewComeco.isHidden = false
        red1.text = nil
        red2.text = nil
        green1.text = nil
        green2.text = nil
        blue1.text = nil
        blue2.text = nil
        //limpar textfields
        imgColor1.backgroundColor = UIColor (red: 247 / 255, green: 250 / 255, blue: 1, alpha: 1)
        imgColor2.backgroundColor = UIColor (red: 247 / 255, green: 250 / 255, blue: 1, alpha: 1)
    }
    
    @IBAction func ratio() {
        let resultRatio = calculateRatio()
        print(resultRatio)
        viewComeco.isHidden = true
        popupView.isHidden = false
        
    }
    
}
                                   

