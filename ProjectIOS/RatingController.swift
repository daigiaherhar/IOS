//
//  RatingController.swift
//  QuanLyMonAn
//
//  Created by Catalina	 on 6/21/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import UIKit
@IBDesignable class RatingControl: UIStackView{
    //Mark: Properties
    @IBInspectable var rating:Int = 0{
        didSet{
            updateButtonState()
        }
    }
    private var buttons = [UIButton]()
    
    @IBInspectable var buttonSize: CGSize = CGSize(width: 44.0, height: 44.0)
    @IBInspectable var buttonCount: Int = 5
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons(){
        for button in buttons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        //load and set image
        let bundle = Bundle(for: type(of: self))
        let imageNormal = UIImage(named: "normal", in: bundle, compatibleWith: self.traitCollection)
        let imageHighlight = UIImage(named: "highlight", in: bundle, compatibleWith: self.traitCollection)
        let imageSelected = UIImage(named: "selected", in: bundle, compatibleWith: self.traitCollection)
        
        buttons.removeAll()
        for _ in 0..<buttonCount{
            let button = UIButton()
            
            //set image and button
            button.setImage(imageNormal, for: .normal)
            button.setImage(imageHighlight, for: .highlighted)
            button.setImage(imageSelected, for: .selected)
            
            
            button.backgroundColor = UIColor.white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            button.addTarget(self, action: #selector(buttonPressd(button:)), for: .touchUpInside)
            //add the button t stack view
            addArrangedSubview(button)
            // add to the button array
            buttons.append(button)
        }
        
    }
    @objc private func buttonPressd(button: UIButton){
        //print("the button is pressed!")
        guard let buttonIndex = buttons.firstIndex(of: button) else{
            fatalError("can not get the button index!")
        }
        //calculate the ratting of rating control
        let selectedRating = buttonIndex + 1
        if selectedRating == rating{
            rating -= 1
        }
        else{
            rating = selectedRating
        }
        updateButtonState()
    }
    private func updateButtonState(){
        for (index, item) in buttons.enumerated(){
            item.isSelected = index < rating
        }
    }
}
