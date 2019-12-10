import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"
import "../utils/Database.js" as DB

Drawer {
    id:drawer
    height: parent.height
    width: Math.min(parent.width, parent.height) / 3 * 2
    parent: Overlay.overlay
    background: Rectangle {
        anchors.fill: parent
        border.width: 0
    }
    Column {
        anchors.fill: parent
        Rectangle {
            height: Styles.menu.itemHeight
            width: drawer.width
            color: Styles.colorTheme.background
            Image {
                source: "../resources/back.svg"
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                sourceSize.width: height
                sourceSize.height: parent.height * 0.7
                x: parent.width - width - parent.height * 0.15
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    drawer.close();
                }
            }
         }
        MenuItem {
            text: qsTr("Добавить проект")
        }
        MenuItem {
            text: qsTr("Добавить каталог мулине")
            onClicked: {
                drawer.close();
                addBrandPopup.open();
            }
        }
        MenuItem {
            text: qsTr("Подобрать похожий оттенок")
        }
        AddBrandPopup {
            id: addBrandPopup
        }
    }
}
