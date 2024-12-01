//
//  AnimalKeyboardView.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

protocol AnimalKeyboardViewDelegate: AnyObject {
    func selectedAnimalChanged(selectedAnimals: Int)
}

class AnimalKeyboardView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AnimalKeyboardViewDelegate?
    private var animalViews: Array<AnimalView> = [
        AnimalView(koreanString: "산토끼", imageName: "hare"),
        AnimalView(koreanString: "거북이", imageName: "tortoise"),
        AnimalView(koreanString: "강아지", imageName: "dog"),
        AnimalView(koreanString: "고양이", imageName: "cat"),
        AnimalView(koreanString: "도마뱀", imageName: "lizard"),
        AnimalView(koreanString: "새", imageName: "bird"),
        AnimalView(koreanString: "무당벌레", imageName: "ladybug"),
        AnimalView(koreanString: "물고기", imageName: "fish"),
        AnimalView(koreanString: "개미", imageName: "ant")
    ]
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
