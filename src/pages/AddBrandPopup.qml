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
        id: column1
        visible: false
        anchors.fill: parent
        spacing: height / 3
        ComboBox {
            id: comboBox
            width: parent.width
            height: parent.height / 3
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Styles.font.normal
            model: ListModel{}
            textRole: "name"
            currentIndex: 0
            editable: false
            delegate: ItemDelegate {
                       id: itemDelegate
                       width: parent.width
                       text: comboBox.textRole ? (Array.isArray(comboBox.model) ? modelData[comboBox.textRole] : model[comboBox.textRole]) : modelData
                       font.pixelSize: Styles.font.normal

                       contentItem: Label {
                           text: itemDelegate.text
                           font: itemDelegate.font
                           elide: Label.ElideRight
                           verticalAlignment: Label.AlignVCenter
                           horizontalAlignment: Label.AlignHCenter
                       }
                   }

           background: Rectangle {
               anchors.fill: parent
               color: Styles.colorTheme.background
           }
           indicator:Image {
               id: icon
               horizontalAlignment: Image.AlignRight
               source: "../resources/arrow.svg";
               sourceSize.height: textField.height
               sourceSize.width: height
               x: comboBox.width - sourceSize.height
           }
           contentItem: Text {
               anchors.fill: parent
               text: comboBox.displayText
               font: comboBox.font
               color: "white"
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               elide: Text.ElideRight
           }
        }
        Row {
            height: parent.height / 3
            width: parent.width
            spacing: width * 0.1
            RecButton {
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.45
                btext: qsTr("Отмена")
                onClicked: {
                    popup.close();
                }
            }
            RecButton {
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.45
                btext: qsTr("Добавить")
                onClicked: {
                    var item = comboBox.model.get(comboBox.currentIndex)
                    DB.insertBrandInStock(item.id);
                    colorBasePage.addBrand(item);
                    popup.close();
                }
            }
        }
    }
    Column {
        id: column2
        visible: false
        anchors.fill: parent
        spacing: height/3
        Text {
            id: text
            width: parent.width
            height: parent.height / 3
            font.pixelSize: Styles.font.normal
            font.family: Styles.font.family
            text: "Нет доступных брендов!"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#707070"
        }
        RecButton {
            height: parent.height/3
            width: parent.width
            btext: qsTr("Ок")
            onClicked: {
                popup.close();
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            var brands = DB.getUnusedBrands();
            if (brands.length === 0) {
                column1.visible = false
                column2.visible = true
            } else {
                column2.visible = false
                comboBox.model.clear();
                comboBox.currentIndex = 0;
                comboBox.model.append(brands);
                column1.visible = true
            }
        }
    }
}
