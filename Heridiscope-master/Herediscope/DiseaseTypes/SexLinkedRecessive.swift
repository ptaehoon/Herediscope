//
//  SexLinkedRecessive.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import Foundation

class SexLinkedRecessive {
    var parent1: Genotype
    var parent2: Genotype
    var parent1Gender: Gender
    var parent2Gender: Gender
    var child: Gender
    
    init() {
        parent1 = Genotype.NotSet
        parent2 = Genotype.NotSet
        parent1Gender = Gender.NotSet
        parent2Gender = Gender.NotSet
        child = Gender.NotSet
    }
    
    init(parentOne: Genotype, parentTwo: Genotype, parentOneGender: Gender, parentTwoGender: Gender, childv: Gender) {
        self.parent1 = parentOne
        self.parent2 = parentTwo
        parent1Gender = parentOneGender
        parent2Gender = parentTwoGender
        child = childv
    }
    
    func percentage() -> Double {
        var ans: Double = 0.0;
        if (parent1 == Genotype.Expressed) {
            if(parent2 == Genotype.Expressed) {
                ans = 100.0;
            } else if (parent1Gender == Gender.Male) {
                ans = 75.0
            } else {
                ans = child == Gender.Female ? 100.0 : 0.0
            }
        } else if (parent2 == Genotype.Expressed) {
            if (parent2Gender == Gender.Male) {
                ans = 75.0
            } else {
                ans = child == Gender.Female ? 100.0 : 0.0
            }
        }
        return ans;
    }
}
