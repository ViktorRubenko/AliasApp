//
//  GameSettings.swift
//  Alias
//
//  Created by Даниил Симахин on 07.05.2022.
//

import Foundation

struct FrequencyActions {
    let list = [1: "Редко", 2: "Нормально", 3: "Часто"]
}

enum SettingsCellType{
    case numberRounds, timeRounds, frequencyActions
}

struct SettingCell {
    let titleLabel: String
    let subTitleLabel: String
    let sliderMinValue: Int
    let sliderMaxValue: Int
    let type: SettingsCellType
}

struct GameSettings {
    let settingsCells = [ SettingCell(titleLabel: "Количество раундов", subTitleLabel: "общее число раундов для каждой команды", sliderMinValue: 2, sliderMaxValue: 10, type: .numberRounds),
                          SettingCell(titleLabel: "Время раунда", subTitleLabel: "продолжительность в секундах", sliderMinValue: 30, sliderMaxValue: 120, type: .timeRounds),
                          SettingCell(titleLabel: "Частота действий", subTitleLabel: "вероятность выпадания действий", sliderMinValue: 1, sliderMaxValue: 3, type: .frequencyActions)
                      ]
    let frequencyActionsList = FrequencyActions()
}
