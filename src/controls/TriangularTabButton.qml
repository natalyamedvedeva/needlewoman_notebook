import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import Styles 1.0
import Units 1.0
import"../utils/Database.js" as DB

TabButton {
    id: tabButton
    property alias buttonText: buttonText.text
    property bool active: false
    property int brand_id: 0
    width: Styles.tabButton.width
    height: Styles.tabButton.height
    anchors.bottom: parent.bottom
    background:  TabButtonShape {
        id: background
        color: active ? Styles.colorTheme.active : Styles.colorTheme.notActive
    }
    Text {
        id: buttonText
        anchors {
            centerIn: parent
        }
        font.family: Styles.font.family
        font.pixelSize: Styles.font.normal
    }
    onPressAndHold: {
        if (active) {
            contextMenu.popup();
        }
    }

    Menu {
        id: contextMenu
        width: Units.dp(100);
        modal: true
        background: Rectangle {
            anchors.fill: parent
            border.width: 0
        }

        MenuItem {
            text: "Скрыть"
            font.pixelSize: Styles.font.small
            font.family: Styles.font.family
            leftPadding: Units.dp(25)
            onClicked: {
                contextMenu.close();
                DB.hideBrand(brand_id);
                colorBasePage.deleteBrand(brand_id);
            }
        }
        MenuItem {
            text: "Удалить"
            font.pixelSize: Styles.font.small
            font.family: Styles.font.family
            leftPadding: Units.dp(23)
            onClicked: {
                contextMenu.close();
                DB.deleteBrand(brand_id);
                colorBasePage.deleteBrand(brand_id);
            }
       }
    }
}
