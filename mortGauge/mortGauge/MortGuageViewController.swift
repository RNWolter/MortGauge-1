//
//  ViewController.swift
//  mortgageTest
//
//  Created by Rick Wolter on 10/21/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import UIKit

class MortGaugeViewController: UIViewController {
    
    
    var result: Double?
    var calculationController = CalculationController()
    
    @IBOutlet weak var homePriceTextField: UITextField!
    @IBOutlet weak var downPaymentTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var termPickerView: UIPickerView!
    
    @IBOutlet weak var calculationResultLabel: UILabel!
    

    @IBOutlet weak var taxesTextField: UITextField!
    @IBOutlet weak var insuranceTextField: UITextField!
    @IBOutlet weak var HOATextField: UITextField!
    
    var termLengthPickerData: [String] = {
        let terms = ["15", "20", "25", "30"]
        return terms
    }()
    
    //termLengthPicker
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        let loanTermIndex = termPickerView.selectedRow(inComponent: 0)
       
        guard let homePriceString = homePriceTextField.text, let downPaymentString = downPaymentTextField.text, let interestRateString = interestRateTextField.text else {return}
        guard let homePrice = Double(homePriceString), let downPayment = Double(downPaymentString), let interestRate = Double(interestRateString), let loanTerm = Int(termLengthPickerData[loanTermIndex]) else {return}
        
        var taxes: Double = 0
        
        if let taxesString = taxesTextField.text,
            let userTaxes = Double(taxesString) {
            taxes = userTaxes
        }
        
        var insurance: Double = 0
        
        if let insuranceString = insuranceTextField.text,
            let userInsurance = Double(insuranceString) {
            insurance = userInsurance
        }
        
        var HOA: Double = 0
        
        if let HOAString = HOATextField.text,
            let userHOA = Double(HOAString) {
            HOA = userHOA
        }
        
        
      
        calculationController.createCalculation(homePrice: homePrice, downPayment: downPayment,  interestRate:
            interestRate, loanTerm: loanTerm, HOA: HOA, taxes: taxes,insurance: insurance  )
     
        updateViews()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termPickerView.dataSource = self
        termPickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        
        guard let result = calculationController.calculations.last?.monthlyPayments() else {return}
        calculationResultLabel.text = String(result)
        
        homePriceTextField.text = ""
        downPaymentTextField.text = ""
        interestRateTextField.text = ""
        
    }
}

extension MortGaugeViewController: UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return termLengthPickerData.count
    }
}

extension MortGaugeViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return termLengthPickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
}

