//
//  AutosomalDominant.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import Foundation

class AutosomalDominant {
    var parent1: Genotype
    var parent2: Genotype
    
    init() {
        parent1 = Genotype.NotSet
        parent2 = Genotype.NotSet
    }
    
    init(parentOne: Genotype, parentTwo: Genotype) {
        self.parent1 = parentOne
        self.parent2 = parentTwo
    }
    
    func percentage() -> Double {
        var ans: Double = 0.0;
        switch parent1 {
        case Genotype.Expressed:
            switch parent2 {
            case Genotype.Expressed:
                ans = 87.5
            case Genotype.NonExpressed:
                ans = 75.0
            case Genotype.Homozygous:
                ans = 100.0
            case Genotype.Heterozygous:
                ans = 87.5
            default:
                ans = 85.0 // THIS IS SUS o.O
            }
        case Genotype.Heterozygous:
            switch parent2 {
            case Genotype.Expressed:
                ans = 87.5
            case Genotype.NonExpressed:
                ans = 50.0
            case Genotype.Homozygous:
                ans = 100.0
            case Genotype.Heterozygous:
                ans = 87.5
            default:
                ans = 75.0
            }
        case Genotype.Homozygous:
            ans = 100.0
        case Genotype.NonExpressed:
            switch parent2 {
            case Genotype.Expressed:
                ans = 75.0
            case Genotype.NonExpressed:
                ans = 0.0
            case Genotype.Homozygous:
                ans = 100.0
            case Genotype.Heterozygous:
                ans = 50.0
            default:
                ans = 50.0
            }
        default:
            switch parent2 {
            case Genotype.Expressed:
                ans = 85.0
            case Genotype.NonExpressed:
                ans = 50.0
            case Genotype.Homozygous:
                ans = 100.0
            case Genotype.Heterozygous:
                ans = 75.0
            default:
                ans = -1.0
            }
        }
        return ans;
    }
}
