//
//  Calculator.swift
//  mortgageTest
//
//  Created by Rick Wolter on 10/22/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//
import Foundation

struct Calculation{
    
    var homePrice: Double
    var downPayment: Double
    var loanTerm: Int
    var interestRate: Double
    var taxes: Double
    var HOA: Double
    var insurance: Double
    
    var loanAmount: Double {
        return homePrice - downPayment   }
    
    var payment: Double {
        return loanAmount / (Double(loanTerm) * 12.0)
    }
  func monthlyPayments() -> String{
    //        Number of Periodic Payments (n) = Payments per year times number of years
    //        Periodic Interest Rate (i) = Annual rate divided by number of payments per
    //        Discount Factor (D) = {[(1 + i) ^n] - 1} / [i(1 + i)^n]
    let numberOfPeriodicPayment = Double(loanTerm * 12)
    let periodicInterestRate = interestRate / 12
    
    let discountFactor = ((pow((1 + periodicInterestRate),numberOfPeriodicPayment) - 1) / (pow( (1 + periodicInterestRate), numberOfPeriodicPayment) * periodicInterestRate))


    let additional = (HOA ) + (taxes) + (insurance)
    let monthlyPayment = loanAmount/discountFactor + additional / 12
    
    print("Here is the monthly Payment \(monthlyPayment)")
    return String(format: "%.2f",monthlyPayment)
    
    }


    
   
    init(homePrice: Double,downPayment: Double,interestRate: Double,loanTerm: Int, HOA: Double, taxes: Double, insurance: Double ) {
        self.homePrice = homePrice
        self.downPayment = downPayment
        self.interestRate = interestRate
        self.loanTerm = loanTerm
        self.HOA = HOA
        self.taxes = taxes
        self.insurance = insurance
        
    }
}

