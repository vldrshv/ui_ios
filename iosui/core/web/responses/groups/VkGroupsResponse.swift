//
//  VkGroupsResponse.swift
//  iosui
//
//  Created by Владислав Ершов on 27.03.2021.
//

import Foundation


struct VkGroupsResponse : Codable {
    let id: Int?
    let isMember: Int?
    let name: String?
    let photo50: String?
}


//{
//id = 11705842;
//"is_admin" = 0;
//"is_advertiser" = 0;
//"is_closed" = 0;
//"is_member" = 1;
//name = "\U041c\U0430\U043d\U0447\U0435\U0441\U0442\U0435\U0440 \U042e\U043d\U0430\U0439\U0442\U0435\U0434 / ManUtd.one";
//"photo_100" = "https://sun1-14.userapi.com/s/v1/ig2/p_neyZNdfYtIj3xGPO669XRKvVNJa_QMMZlHOqsW8iRswiH6HOVvbMh49R87ExZ_zPhdfaAVuguVYdi2Zb1AbVMT.jpg?size=100x0&quality=96&crop=0,0,1080,1080&ava=1";
//"photo_200" = "https://sun1-14.userapi.com/s/v1/ig2/6YojP6y6mjf3L-hqw8Ne5KsoBsjt5HmTAiE-2RGyVKp38RPQABuVonTqq_Dm2vxemQaKS_2AfpPBDu6DgdsYgjiu.jpg?size=200x0&quality=96&crop=0,0,1080,1080&ava=1";
//"photo_50" = "https://sun1-14.userapi.com/s/v1/ig2/zRNkTG72mDR3QPjn2_duvXbbTl51b-T8e0__Mdgvd7tg9Qc9nMB_5UabZBr_uVoUZTYF-tF5ilmMOm05UbdnrRcX.jpg?size=50x0&quality=96&crop=0,0,1080,1080&ava=1";
//"screen_name" = manutdone;
//type = page;
//}
