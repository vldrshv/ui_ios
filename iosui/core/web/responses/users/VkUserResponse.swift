//
//  VkUserResponse.swift
//  iosui
//
//  Created by Владислав Ершов on 27.03.2021.
//

import Foundation
import RealmSwift

class VkUserResponse : Object, Decodable {
    @objc dynamic var id: Int = -1
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var lastSeen: VkUserOnlineStatus? = VkUserOnlineStatus()
    @objc dynamic var online: Int = -1
    @objc dynamic var photo50: String = ""
}

class VkUserOnlineStatus : Object, Decodable {
    @objc dynamic var platform: Int = -1
    @objc dynamic var time: CLong = -1
}

// MARK: DATA EXAMPLE

//{
//"can_access_closed" = 1;
//"first_name" = "\U0410\U043b\U0435\U043a\U0441\U0430\U043d\U0434\U0440";
//id = 59411873;
//"is_closed" = 0;
//"last_name" = "\U0421\U0442\U0443\U043f\U0430\U043a";
//"last_seen" =                 {
//platform = 4;
//                    1 — мобильная версия;
//                    2 — приложение для iPhone;
//                    3 — приложение для iPad;
//                    4 — приложение для Android;
//                    5 — приложение для Windows Phone;
//                    6 — приложение для Windows 10;
//                    7 — полная версия сайта.
//time = 1616842099;
//};
//online = 0;
//"photo_50" = "https://sun1-86.userapi.com/s/v1/ig2/6747eCDOQfEwKLF66tuoSK-eG0xnuwtfEIhIRBdWCP-dOFn303JyF6mcOtCBC2AqmVJWe_nYFnZ_LYi6Jf56iBZl.jpg?size=50x0&quality=96&crop=366,514,990,990&ava=1";
//"track_code" = "2d7da3d5hAhJ4lHNI1i7rOkGjRwrJLaDcOy89uv8tAHugiQAdKfpYxbWaMx8XLz-0_JDjIdH1o5n99mY";
//}

