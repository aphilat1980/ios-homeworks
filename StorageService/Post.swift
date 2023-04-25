import UIKit

public struct Post {
    public var author: String
    public var my_description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public extension Post {
    
    static func make() -> [Post] {
        [
            Post(author: "Ivanov Ivan", my_description: "Много споров вызывает также история происхождения кошек, которая тоже весьма неоднозначна. Самое распространенное мнение, которое, кстати, особенно прижилось в России, заключается в том, что единым предком современных кошек является переднеазиатская североафриканская степная кошка, которая была одомашнена вовсе не в Египте, а в Нубии, и произошло это около 4 тысяч лет назад. Только после этого кошки попали в Египет, а затем появились и в Азии, где успешно скрестились с лесными бенгальскими видами", image: "1stPostImage", likes: 10, views: 100),
            Post(author: "Petrov Petr", my_description: "Инопланетя́нин, пришелец (с других планет, из космоса), чужой (англ. alien, «чужой») — гипотетическое разумное существо внеземного происхождения, персонаж массовой культуры, в том числе художественных произведений, уфологии, конспирологии; (в частности, о вторжении инопланетян) и некоторых новых религиозных движений", image: "2ndPostImage", likes: 15, views: 150),
            Post(author: "Sidorov Oleg", my_description: "Коктейль - \"Горящая ламбрджини\": Наливаем в коктейльную рюмку сначала кофейный ликёр, затем самбуку так, чтобы она легла верхним слоем. В одну рюмку наливаем Айриш крим, в другую — Блю Кюрасао. Поджигаем самбуку, затем вливаем в коктейльную рюмку сразу содержимое двух рюмок, пока гость пьёт.", image: "3rdPostImage", likes: 20, views: 21),
            Post(author: "Bogdanov Bogdan", my_description: "Скелет - совокупность костей человеческого организма, пассивная часть опорно-двигательного аппарата. Служит опорой мягким тканям, точкой приложения мышц, вместилищем и защитой внутренних органов. Костная ткань скелета развивается из мезенхимы.", image: "4thPostImage", likes: 15, views: 231)
        ]
        
    }
}
public struct PhotoImages {
    public var photo: String
}

public extension PhotoImages {
   static func make() -> [PhotoImages] {
        [PhotoImages(photo: "1"), PhotoImages(photo:"2"), PhotoImages(photo:"3"), PhotoImages(photo:"4"), PhotoImages(photo:"5"), PhotoImages(photo:"6"), PhotoImages(photo:"7"), PhotoImages(photo:"8"), PhotoImages(photo:"9"), PhotoImages(photo:"10"), PhotoImages(photo:"11"), PhotoImages(photo:"12"), PhotoImages(photo:"13"), PhotoImages(photo:"14"), PhotoImages(photo:"15"), PhotoImages(photo:"16"), PhotoImages(photo:"17"), PhotoImages(photo:"18"), PhotoImages(photo:"19"), PhotoImages(photo:"20")]
    }
    
    static func makeImageArray () -> [UIImage] {
        /*[UIImage(named: "1")!, UIImage(named: "2")!,UIImage(named: "3")!,
         UIImage(named: "4")!, UIImage(named: "5")!,UIImage(named: "6")!,
         UIImage(named: "7")!, UIImage(named: "8")!,UIImage(named: "9")!,
         UIImage(named: "10")!, UIImage(named: "11")!,UIImage(named: "12")!,
         UIImage(named: "13")!, UIImage(named: "14")!,UIImage(named: "15")!,
         UIImage(named: "16")!, UIImage(named: "17")!,UIImage(named: "18")!,
         UIImage(named: "19")!, UIImage(named: "20")!]*/
        var array: [UIImage] = []
        for i in 1...20 {
            array.append(UIImage(named: "\(i)") ?? UIImage())
        }
        return array
    }
        
}