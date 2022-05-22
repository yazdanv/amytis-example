//
//  AppDelegate.swift
//  MasterSecurity
//
//  Created by Yazdan Vakili on 2/27/18.
//  Copyright © 2018 Yazdan Vakili. All rights reserved.
//

import UIKit
import Amytis
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Amytis.config(AppDelegate.self, address: Address("192.168.1.2", 8484))
        Amytis.colors["ymain"] = "fbc601"
        Amytis.colors["bbtn"] = "066eaa"
        Amytis.colors["bl"] = "dbe6e6"
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        let adding = """
        
        
        قسمت تنظیمات خروجی ها

        دریافت تایید :
        در صورت غیر فعال شدن ، پیغام مربوط به تغییر وضعیت خروجی ها برای شما ارسال نخواهد شد ‌.
        نوع عملکرد خروجی ها:
        در قسمت میتوانید عملکرد هر یک از خروجی ها را به صورت جداگانه تعیین نمایید . تغییرات این قسمت در صفحه مربوط به خروجی ها (صفحه اصلی) قابل مشاهده میباشد .
        """
        Amytis.language.setDefault(defaultLanguage: .persian, keys: [
            "help1": [.persian: "در این قسمت نام محلی که دستگاه نصب شده است و شماره سیم کارت داخل دستگاه و رمز چهار رقمی دستگاه را وارد کرده و سپس مدل دستگاه خود را انتخاب کنید. سپس دکمه ی ذخیره را فشار دهید. اضافه کردن محل4 برای اضافه کردن یک محل جدید ابتدا دکمه ی جدید را فشار دهید سپس اطلاعات را وارد کرده و ذخیره را فشار دهید. قسمت دریافت تایید برای خروجی ها4 در صورتی که هر خروجی را غیر فعال کنید پیام روشن یا خاموش شدن آن خروجی برای شما ارسال نمی شود.\(adding)"],
            "help10": [.persian: "در صورتی که میخواهید فقط یکی از موارد را تنظیم کنید، از کلید ارسال استفاده کرده و در صورتی که قصد انجام کلیه تنظیمات را دارید، از کلید ارسال همه موارد استفاده کنید.  نکته: از طریق قسمت کنترل دسترسی کاربرها می توانید هریک از کاربرها را به طور موقتی غیر فعال نمائید. (منظور از کاربرها ریموت های شماره 1 تا 8 می باشد)."],
            "help11": [.persian: "پس از نصب نرم افزار، ابتدا باید اطلاعات مربوط به دستگاه و محل نصب را از طریق قسمت تنظیمات محل نصب در نرم افزار ذخیره کنید. پس از ذخیره، نام محل نصب بالای تمامی صفحات نمایش داده می شود.  در صورتی که از سیستم حفاظتی مَستر در محل دیگری نیز استفاده می کنید، با اضافه کردن این محل از طریق نرم افزار، سیستم های حفاظتی ذخیره شده را کنترل نمائید. قبل از ارسال دستور، حتما بررسی کنید محل مناسب انتخاب شده باشد. (پیشنهاد می کنیم که از رمز مشابه برای دستگاه های حفاظتی خود استفاده نکنید). پس از مشخص کردن محل مورد نظر، می توانید از طریق منوی تنظیمات، دیگر تنظیمات مورد نظر را انجام دهید. نکته: انجام این تنظیمات تنها برای حافظه شماره یک دستگاه تلفن کننده (مدیر دستگاه) امکان پذیر می باشد. نکته: از طریق گزینه تنظیمات نرم افزار، نوع کاربری را می توانید مشخص نمائید. قسمت تنظیمات برای کاربران عادی نمایش داده نمی شود. راهنمای مربوط به هر صفحه از نرم افزار با کلیک کردن بر روی علامت سوال بالای همان صفحه نمایش داده می شود."],
            "help2": [.persian: "در این قسمت می توانید نوع کاربری را تعیین کنید. در صورتی که شماره شما در حافظه یک دستگاه ذخیره شده است مدیر سیستم را انتخاب کنید و در غیر این صورت کاربر عادی را انتخاب کنید و کلید ذخیره را فشار دهید. در صورتی که می خواهید رمز ورود به نرم افزار را تغییر دهید رمز جدید را به جای رمز قبلی وارد کرده و کلید ذخیره را فشار دهید. با استفاده از قسمت بازگشت به تنظیمات اولیه می توانید نرم افزار را به حالت اولیه ی بعد از نصب برگردانید."],
            "help3": [.persian: "دراین قسمت می توانید شماره های موجود در حافظه تلفن کننده را مشاهده و ویرایش و ذخیره کنید.  همچنین سطح دسترسی شماره های موجود در حافظه 1 تا 5 نیز می توانید تعیین کنید.  قبل از انجام تغییرات بهتر است ابتدا اطلاعات را به روز رسانی یا استعلام کنید و پس از ویرایش توسط کلید ذخیره و ارسال آن برای دستگاه ارسال کنید. توجه : شماره اول حافظه پیام قابل تغییر نمی باشد و به عنوان مدیر سیستم شناخته می شود. حافظه شماره 1 را از طریق دستگاه می توانید تغییر دهید."],
            "help4": [.persian: "در این قسمت می توانید نام زون ها را با توجه به محل تحت پوشش حداکثر در 10 کاراکتر تعیین کنید. کلید ذخیره فقط اطلاعات را در نرم افزار ذخیره می کند  کلید ذخیره و ارسال اطلاعات را در نرم افزار ذخیره کرده و برای دستگاه نیز ارسال می کند (این گزینه برای مدیر سیستم قابل دسترس می باشد) کلید استعلام نام ها اطلاعات را از دستگاه گرفته و نمایش می دهد."],
            "help5": [.persian: "در این قسمت می توانید برای هر یک از کاربرهای سیستم یک نام اختصاص دهید . در دستگاه های ریموتی کاربر ها ریموت های 1 تا 8 هستند."],
            "help6": [.persian: "در این قسمت نام خروجی های متصل به دستگاه را حداکثر در 10 کارکتر تعیین کنید."],
            "help7": [.persian: "در این قسمت مشخصات نصب کننده دستگاه را می توانید ذخیره کنید. این مشخصات پس از اتمام آژیر به صورت یک گزارش برای شما ارسال می شود."],
            "help8": [.persian: "در این قسمت می توانید متن تحریک های تلفن کننده راتغییر دهید (حداکثر 40 کاراکتر)  این متن هنگام آژیر زدن دستگاه برای شماره های موجود در حافظه 1 تا 10 تلفن کننده ارسال می شود."],
            "help9": [.persian: "دستگاه دارای دو زمان سنج داخلی می باشد که قابلیت فعال یا غیر فعال کردن سیستم حفاظتی یا کنترل خروجی رله در زمان مشخص را دارد. (منظور از خروجی رله در دستگاه مدل 910 و 930 خروجی ۱ میباشد).  برای تنظیم هریک از زمان سنج ها تنظیمات مورد نظر را انجام داده و گزینه ذخیره و ارسال را فشار دهید. در صورتی که می خواهید زمان سنج متوقف شود، آن را حذف نمائید. نکته: برای هریک از زمان سنج ها، تنها یک نوع عملکرد قابل ذخیره می باشد."]])
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

