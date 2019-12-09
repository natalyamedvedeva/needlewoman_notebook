import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"
import "../utils/Database.js" as DB

Popup {
    id: popup
    width: Units.dp(320)
    height: Units.dp(180)
    parent: Overlay.overlay
    anchors.centerIn: parent
    leftPadding: width * 0.06
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
                text: tabBar.currentItem.buttonText
                width: parent.width/4
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
            }
            Text {
                text: number
                width: parent.width/4
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Styles.font.normal
                font.family: Styles.font.family
            }
            Rectangle {
                color: flossColor
                width: parent.width/4
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                border.color: "black"
            }

        }
        Counter {
            id: counter
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
                onClicked: {
                    DB.insertFlossInStock(floss_id, counter.value);
                    popup.close();
                    if (counter.value === 0 && toolBar.available !== 2 || counter.value > 0 && toolBar.available === 2) {
                        listView.model.remove(item);
                    } else {
                       item.update(counter.value);
                    }
                }
            }
        }
    }
}
