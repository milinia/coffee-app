// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum CoffeeShopList {
    ///  км от вас
    internal static let fromYou = Strings.tr("Localizable", "coffee_shop_list.from_you", fallback: " км от вас")
    /// На карте
    internal static let onMap = Strings.tr("Localizable", "coffee_shop_list.on_map", fallback: "На карте")
    /// Ближайшие кофейни
    internal static let title = Strings.tr("Localizable", "coffee_shop_list.title", fallback: "Ближайшие кофейни")
  }
  internal enum CoffeeShopMap {
    /// Карта
    internal static let title = Strings.tr("Localizable", "coffee_shop_map.title", fallback: "Карта")
  }
  internal enum Login {
    /// Войти
    internal static let login = Strings.tr("Localizable", "login.login", fallback: "Войти")
    /// Вход
    internal static let title = Strings.tr("Localizable", "login.title", fallback: "Вход")
  }
  internal enum Menu {
    /// Меню
    internal static let title = Strings.tr("Localizable", "menu.title", fallback: "Меню")
    /// Перейти к оплате
    internal static let toOrder = Strings.tr("Localizable", "menu.to_order", fallback: "Перейти к оплате")
  }
  internal enum Order {
    /// Оплатить
    internal static let pay = Strings.tr("Localizable", "order.pay", fallback: "Оплатить")
    /// Время ожидания заказа 15 минут! 
    /// Спасибо, что выбрали нас!
    internal static let status = Strings.tr("Localizable", "order.status", fallback: "Время ожидания заказа 15 минут! \nСпасибо, что выбрали нас!")
    /// Ваш заказ
    internal static let title = Strings.tr("Localizable", "order.title", fallback: "Ваш заказ")
  }
  internal enum Registraion {
    /// Email
    internal static let email = Strings.tr("Localizable", "registraion.email", fallback: "Email")
    /// Пароль
    internal static let password = Strings.tr("Localizable", "registraion.password", fallback: "Пароль")
    /// Повторите пароль
    internal static let repeatePassword = Strings.tr("Localizable", "registraion.repeate_password", fallback: "Повторите пароль")
    /// Localizable.strings
    ///   coffee-shops-app
    /// 
    ///   Created by Evelina on 12.01.2024.
    internal static let title = Strings.tr("Localizable", "registraion.title", fallback: "Регистрация")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
