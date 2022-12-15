//
//  ViewController.swift
//  DrinkWater
//
//  Created by Yiğit Karakurt on 14.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var addWaterConstraint: NSLayoutConstraint!
    
    let waterStore = DataStore()
    let targetAmount = 2700.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sifirla()
        updateAppereance()
    }
    
    func sifirla(){
        waterStore.defaults.set(0, forKey: "currentAmount")
    }
    
    
    func updateWaterLevel(amount: Double){
        let screenHeight = Double(view.frame.size.height)
        let ratio = amount / targetAmount
        let calculatedHeight = screenHeight * ratio
        
        addWaterConstraint.constant = CGFloat(calculatedHeight)
        
        UIViewPropertyAnimator.init(duration: 0.5, dampingRatio: 0.75){
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    func updateLabels(amount: Double){
        let amountToTarget = (targetAmount - amount) / 1000
        
        if amount < targetAmount{
            let subtitleText = String(format: "Bugünkü ihtiyacını karşılamak için \n%g litre daha su içmelisin", amountToTarget)
            subtitleLabel.text = subtitleText
            
            if amount == 0{
                titleLabel.text = "Merhaba! \nBugün su içtin mi?"
            }else{
                titleLabel.text = "Tebrikler! \nDoğru yoldasınız"
            }
        }else{
            titleLabel.text = "Muhteşem! \nKendine iyi baktın"
            subtitleLabel.text = "Bugün vücudun için gereken \nsu miktarının tamamını karşıladın"
        }
        
    }
    
    func updateAppereance(){
        let currentWaterAmount = waterStore.getCurrentAmount()
        
        updateLabels(amount: currentWaterAmount)
        updateWaterLevel(amount: currentWaterAmount)
    }
    
    
    @IBAction func addWaterButtonTapped(_ sender: Any) {
        
        var waterAmount = 0.0
        
        switch (sender as AnyObject).tag {
            case 0:
                waterAmount = 200
            case 1:
               waterAmount = 500
            case 2:
                waterAmount = 800
            default:
                break
        }
        waterStore.addWater(amount: waterAmount)
        updateAppereance()
    }
    
    


}
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
