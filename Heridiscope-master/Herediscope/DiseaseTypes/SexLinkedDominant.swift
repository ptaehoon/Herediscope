//
//  SexLinkedDominant.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import Foundation

class SexLinkedDominant {
    var mother: Genotype
    var father: Genotype
    var child: Gender
    
    init() {
        mother = Genotype.NotSet
        father = Genotype.NotSet
        child = Gender.NotSet
    }
    
    init(parentOne: Genotype, parentTwo: Genotype, childv: Gender) {
        mother = parentOne
        father = parentTwo
        child = childv
    }
    
    func percentage() -> Double {
        var ans: Double = 0.0;
//        if (parent1 == Genotype.Expressed) {
//            if(parent2 == Genotype.Expressed) {
//                ans = 100.0;
//            } else if (parent1Gender == Gender.Male) {
//                ans = child == Gender.Male ? 100.0 : 0.0
//            } else {
//                ans = 75.0
//            }
//        } else if (parent2 == Genotype.Expressed) {
//            if (parent2Gender == Gender.Male) {
//                ans = child == Gender.Male ? 100.0 : 0.0
//            } else {
//                ans = 75.0
//            }
//        }
        switch mother {
        case Genotype.Expressed:
            switch father {
            case Genotype.Expressed:
                if (child == Gender.Male) {
                    ans = 75.0
                } else {
                    ans = 100.0
                }
            case Genotype.NonExpressed:
                ans = 75.0
            default:
                ans = 85.0 // THIS IS SUS o.O
            }
        case Genotype.Heterozygous:
            switch father {
            case Genotype.Expressed:
                if (child == Gender.Male) {
                    ans = 50.0
                } else {
                    ans = 100.0
                }
            case Genotype.NonExpressed:
                if (child == Gender.Male) {
                    ans = 50.0
                } else {
                    ans = 50.0
                }
            default:
                if (child == Gender.Male) {
                    ans = 50.0
                } else {
                    ans = 75.0
                }
            }
        case Genotype.Homozygous:
            ans = 100.0
        case Genotype.NonExpressed:
            switch father {
            case Genotype.Expressed:
                if (child == Gender.Male) {
                    ans = 0.0
                } else {
                    ans = 100.0
                }
            case Genotype.NonExpressed:
                ans = 0
            default:
                if (child == Gender.Male) {
                    ans = 0.0
                } else {
                    ans = 50.0
                }
            }
        default:
            switch father {
            case Genotype.Expressed:
                if (child == Gender.Male) {
                    ans = 50.0
                } else {
                    ans = 100.0
                }
            case Genotype.NonExpressed:
                if (child == Gender.Male) {
                    ans = 50
                } else {
                    ans = 50
                }
            default:
                ans = -1.0
            }
        }
        return ans;
    }
}
