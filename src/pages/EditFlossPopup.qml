import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"

Popup {
    property alias brand: brand.text
    property alias number: number.text
    property alias color: color.color

    id: popup
    width: root.isLandscape() ? root.width * 0.5  : root.width * 0.8
    height: root.isLandscape() ? root.height * 0.6 : root.height * 0.35
    x: (root.width - width) / 2
    y: (root.height - height)/2 - Styles.toolBar.height - Styles.tabButton.height
    leftPadding: width * 0.08
    rightPadding: leftPadding
    modal: true
    background: Rectangle {
        anchors.fill: parent
    }

    Column {
        anchors.fill: parent
        spacing: height / 8
        Row {
            height: parent.height /4
            width: parent.width
            spacing: width / 8
            Text {
                id: brand
                width: parent.width/4
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
            }
            Text {
                id: number
                width: parent.width/4
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
            }
            Rectangle {
                id: color
                width: parent.width/4
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                border.color: "black"
            }

        }
        Counter {
            height: parent.height /4
        }
        Row {
            height: parent.height /4
            width: parent.width
            spacing: width * 0.1
            RecButton {
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                btext: qsTr("Отмена")
                width: parent.width * 0.45
                onClicked: {
                    popup.close()
                }
            }
            RecButton {
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                btext: qsTr("Сохранить")
                width: parent.width * 0.45
            }
        }
    }
}
