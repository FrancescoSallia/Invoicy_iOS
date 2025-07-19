//
//  CurrencyEnum.swift
//  EasyBill
//
//  Created by Francesco Sallia on 19.07.25.
//

import Foundation

enum CurrencyEnum: String, CaseIterable {
    case euro
    case usDollar
    case britishPound
    case japaneseYen
    case swissFranc
    case canadianDollar
    case australianDollar
    case chineseYuan
    case indianRupee
    case southKoreanWon
    case russianRuble
    case swedishKrona
    case norwegianKrone
    case danishKrone
    case polishZloty
    case czechKoruna
    case hungarianForint
    case brazilianReal
    case turkishLira
    case mexicanPeso
    case singaporeDollar
    case newZealandDollar
    case southAfricanRand
    
    var symbol: String {
            switch self {
            case .euro: return "€"
            case .usDollar: return "$"
            case .britishPound: return "£"
            case .japaneseYen: return "¥"
            case .swissFranc: return "CHF"
            case .canadianDollar: return "CA$"
            case .australianDollar: return "A$"
            case .chineseYuan: return "¥"
            case .indianRupee: return "₹"
            case .southKoreanWon: return "₩"
            case .russianRuble: return "₽"
            case .swedishKrona: return "kr"
            case .norwegianKrone: return "kr"
            case .danishKrone: return "kr"
            case .polishZloty: return "zł"
            case .czechKoruna: return "Kč"
            case .hungarianForint: return "Ft"
            case .brazilianReal: return "R$"
            case .turkishLira: return "₺"
            case .mexicanPeso: return "$"
            case .singaporeDollar: return "S$"
            case .newZealandDollar: return "NZ$"
            case .southAfricanRand: return "R"
            }
        }
    var code: String {
        switch self {
        case .euro: return "EUR"
        case .usDollar: return "USD"
        case .britishPound: return "GBP"
        case .japaneseYen: return "JPY"
        case .swissFranc: return "CHF"
        case .canadianDollar: return "CAD"
        case .australianDollar: return "AUD"
        case .chineseYuan: return "CNY"
        case .indianRupee: return "INR"
        case .southKoreanWon: return "KRW"
        case .russianRuble: return "RUB"
        case .swedishKrona: return "SEK"
        case .norwegianKrone: return "NOK"
        case .danishKrone: return "DKK"
        case .polishZloty: return "PLN"
        case .czechKoruna: return "CZK"
        case .hungarianForint: return "HUF"
        case .brazilianReal: return "BRL"
        case .turkishLira: return "TRY"
        case .mexicanPeso: return "MXN"
        case .singaporeDollar: return "SGD"
        case .newZealandDollar: return "NZD"
        case .southAfricanRand: return "ZAR"
        }
    }
}
