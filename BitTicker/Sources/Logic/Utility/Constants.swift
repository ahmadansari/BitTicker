//
//  Constants.swift
//  
//
//  Created by Ahmad Ansari on 10/22/18.
//  Copyright © 2018 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: - Logger Constants
    static let loggerFormat         = "$D[HH:mm:ss]$d $L: $M"
    
    // MARK: - Database Constants
    static let XCDataModelFile      = "Tickers"
    static let XCDataModelType      = "momd"
    static let XCDataStoreType      = "sqlite"
    static let XCDataSQLiteFile     = "Tickers.sqlite"
    
    // MARK: - Notification Names
    static let notifCoreDataResetPerformed = "CoreDataResetPerformed"
    
    // MARK: - Service Constants
    static let channelURL           = "wss://api2.poloniex.com"
}

enum CurrencyPairIDs: Int32 {
    case BTC_BCN = 7
    case BTC_BTS = 14
    case BTC_BURST = 15
    case BTC_CLAM = 20
    case BTC_DASH = 24
    case BTC_DGB = 25
    case BTC_DOGE = 27
    case BTC_GAME = 38
    case BTC_HUC = 43
    case BTC_LTC = 50
    case BTC_MAID = 51
    case BTC_OMNI = 58
    case BTC_NAV = 61
    case BTC_NMC = 64
    case BTC_NXT = 69
    case BTC_PPC = 75
    case BTC_STR = 89
    case BTC_SYS = 92
    case BTC_VIA = 97
    case BTC_VTC = 100
    case BTC_XCP = 108
    case BTC_XEM = 112
    case BTC_XMR = 114
    case BTC_XPM = 116
    case BTC_XRP = 117
    case USDT_BTC = 121
    case USDT_DASH = 122
    case USDT_LTC = 123
    case USDT_NXT = 124
    case USDT_STR = 125
    case USDT_XMR = 126
    case USDT_XRP = 127
    case XMR_BCN = 129
    case XMR_DASH = 132
    case XMR_LTC = 137
    case XMR_MAID = 138
    case XMR_NXT = 140
    case BTC_ETH = 148
    case USDT_ETH = 149
    case BTC_SC = 150
    case BTC_FCT = 155
    case BTC_DCR = 162
    case BTC_LSK = 163
    case ETH_LSK = 166
    case BTC_LBC = 167
    case BTC_STEEM = 168
    case ETH_STEEM = 169
    case BTC_SBD = 170
    case BTC_ETC = 171
    case ETH_ETC = 172
    case USDT_ETC = 173
    case BTC_REP = 174
    case USDT_REP = 175
    case ETH_REP = 176
    case BTC_ARDR = 177
    case BTC_ZEC = 178
    case ETH_ZEC = 179
    case USDT_ZEC = 180
    case XMR_ZEC = 181
    case BTC_STRAT = 182
    case BTC_PASC = 184
    case BTC_GNT = 185
    case ETH_GNT = 186
    case BTC_BCH = 189
    case ETH_BCH = 190
    case USDT_BCH = 191
    case BTC_ZRX = 192
    case ETH_ZRX = 193
    case BTC_CVC = 194
    case ETH_CVC = 195
    case BTC_OMG = 196
    case ETH_OMG = 197
    case BTC_GAS = 198
    case ETH_GAS = 199
    case BTC_STORJ = 200
    case BTC_EOS = 201
    case ETH_EOS = 202
    case USDT_EOS = 203
    case BTC_SNT = 204
    case ETH_SNT = 205
    case USDT_SNT = 206
    case BTC_KNC = 207
    case ETH_KNC = 208
    case USDT_KNC = 209
    case BTC_BAT = 210
    case ETH_BAT = 211
    case USDT_BAT = 212
    case BTC_LOOM = 213
    case ETH_LOOM = 214
    case USDT_LOOM = 215
    case USDT_DOGE = 216
    case USDT_GNT = 217
    case USDT_LSK = 218
    case USDT_SC = 219
    case USDT_ZRX = 220
    case BTC_QTUM = 221
    case ETH_QTUM = 222
    case USDT_QTUM = 223
    case USDC_BTC = 224
    case USDC_ETH = 225
    case USDC_USDT = 226
    case BTC_MANA = 229
    case ETH_MANA = 230
    case USDT_MANA = 231
    case BTC_BNT = 232
    case ETH_BNT = 233
    case USDT_BNT = 234
    case USDC_BCH = 235
    case BTC_BCHABC = 236
    case USDC_BCHABC = 237
    case BTC_BCHSV = 238
    case USDC_BCHSV = 239
    case USDC_XRP = 240
    case USDC_XMR = 241
    case USDC_STR = 242
    case USDC_DOGE = 243
    case USDC_LTC = 244
    case USDC_ZEC = 245
    case BTC_FOAM = 246
    case USDC_FOAM = 247
    case BTC_NMR = 248
    case BTC_POLY = 249
    case BTC_LPT = 250
    case BTC_GRIN = 251
    case USDC_GRIN = 252
    
    func description() -> String {
        return "\(self)"
    }
}

//UI Constants
extension UIColor {
    static var stockRed: UIColor {
        return UIColor(red: 255.0/255.0,
                       green: 59.0/255.0,
                       blue: 48.0/255.0,
                       alpha: 1.0)
    }
    
    static var stockGreen: UIColor {
        return UIColor(red: 76.0/255.0,
                       green: 217.0/255.0,
                       blue: 99.0/255.0,
                       alpha: 1.0)
    }
}

enum Message: String {
    //Sucess Messages
    case signUpSuccess = "User Created Sucessfully"
    
    //Error Messages
    case alreadyExists = "User Already Exists"
    case invalidCredentials = "Invalid Credentials"
    case emptyUsername = "Username Field is Empty"
    case emptyPassword = "Password Field is Empty"
    case passwordMismatch = "Passwords does not match"
    case general = "Something Went Wrong"
}

// MARK: - Storyboard Constants
enum Storyboard: String {
    
    // MARK: Storyboard Names
    case main = "Main"
    
    // MARK: Storyboard Utility Methods
    var initialViewController: UIViewController? {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController()
    }
    
    func initialController<T: UIViewController>() -> T? {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() as? T
    }
    
    func viewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
