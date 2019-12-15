import QtQuick 2.12
import QtQuick.Controls 2.12
import Styles 1.0
import Units 1.0

Page {
    title: "О приложении"
    Flickable {
        ScrollBar.vertical: ScrollBar {}
        Column {
            spacing: Units.dp(16)
            padding: Units.dp(16)
            Text {
                text: qsTr("Блокнот вышивальщицы")
                font.pixelSize: Styles.font.large
                font.family: Styles.font.family
                font.weight: Font.DemiBold
            }
            Text {
                text: "Версия 0.9"
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
                bottomPadding: Units.dp(16)
            }
            Text {
                text: qsTr("Автор")
                font.pixelSize: Styles.font.large
                font.family: Styles.font.family
                font.weight: Font.DemiBold
            }
            Text {
                text: "Наталья Медведева"
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
                bottomPadding: Units.dp(16)
            }
            Text {
                text: qsTr("E-mail")
                font.pixelSize: Styles.font.large
                font.family: Styles.font.family
                font.weight: Font.DemiBold
            }
            Text {
                text: "natalya.medvedeva2705@gmail.com"
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
                bottomPadding: Units.dp(16)
            }
        }
    }
}
