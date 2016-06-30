//
//  URLConstant.h
//  IFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#ifndef URLConstant_h
#define URLConstant_h

#define SERVER_ADDRESS @"http://192.168.1.157:9099"

#define LOGIN_URL [NSString stringWithFormat:@"%@/ticketOrderSystem/admin/qrlogin", SERVER_ADDRESS]

#define QRCODE_SCAN_RESULT_URL [NSString stringWithFormat:@"%@/ticketOrderSystem/admin/scanner", SERVER_ADDRESS]

#endif /* URLConstant_h */
