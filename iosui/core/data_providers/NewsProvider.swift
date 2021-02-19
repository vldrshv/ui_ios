//
//  NewsProvider.swift
//  iosui
//
//  Created by vlad on 16.02.2021.
//

import Foundation


class NewsProvider {
    static let lables = [
        "На основе предыдущего ПЗ",
        "Сделать группировку друзей по первой букве фамилии. Добавить header секции для таблицы со списком друзей. Он должен содержать первую букву фамилии и иметь полупрозрачный цвет фона, цвет которого совпадает с цветом таблицы",
        "Добавьте UISearchBar в header таблицы со списком друзей и групп. Укажите контроллер, содержащий эту таблицу, делегатом UISearchBar, реализуйте поиск с выводом результатов в ту же таблицу. Для простоты реализации не стоит использовать UISearchController (задание на самостоятельный поиск решения)",
        "Создать экран новостей. Добавить туда таблицу и сделать ячейку для новости. Ячейка должна содержать то же самое, что и в оригинальном приложении ВКонтакте: надпись, фотографии, кнопки «Мне нравится», «Комментировать», «Поделиться» и индикатор количества просмотров. Сделать поддержку только одной фотографии, которая должна быть квадратной формы и растягиваться на всю ширину ячейки. Высота ячейки должна вычисляться автоматически",
        "*В ячейку новости добавить отображение нескольких фотографий. Они должны располагаться в квадратной зоне, ширина которой равна ширине ячейки. В идеале нужно сделать равномерное расположение фотографий в квадратной области (необязательное, для тех, у кого есть время)]"
    ]
    static let likes = [1000, 1, 3, 4, 0]
    static let isLiked = [true, false, true, true, false]
    static let imgPath = ["adidas", "adidas", "adidas", "adidas", "adidas"]
    
    static func getNewsCount() -> Int {
        return min(lables.count, likes.count, isLiked.count, imgPath.count)
    }
    
    static func getTitleAt(index: IndexPath) -> String {
        return lables[index.item]
    }
    
    static func getImagePathAt(index: IndexPath) -> String {
        return imgPath[index.item]
    }
    
    static func getIsLiked(index: IndexPath) -> Bool {
        return isLiked[index.item]
    }
    
    static func getLikesCount(index: IndexPath) -> Int {
        return likes[index.item]
    }
    
}