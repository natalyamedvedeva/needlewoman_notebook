import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import Styles 1.0
import Units 1.0
import "../pages"

ToolBar {
    property alias filter: textField.text
    property alias available: comboBox.currentIndex
    width: parent.width
    height: Styles.toolBar.height
    background: Rectangle {
        anchors.fill: parent
        color: Styles.colorTheme.background
    }
    RowLayout {
        anchors.fill: parent
        ToolButton {
            Layout.leftMargin: (Styles.toolBar.height - textField.height - width + icon.width)/2
            icon.source: "../resources/menu_icon.svg"
            icon.color: "white"
            background: Rectangle {
                anchors.fill: parent
                color: Styles.colorTheme.background
            }
            onClicked: {
                menu.open();
            }
        }
        MenuPage {
            id: menu
        }

        TextField {
            id: textField
            font.pixelSize: Styles.font.normal
            inputMethodHints: Qt.ImhNoPredictiveText
            font.family: Styles.font.family
            background: Rectangle {
            }
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            placeholderText: qsTr("Найти оттенок...")
            onTextChanged: {
                colorBasePage.update();
            }
        }
        ComboBox {
            id: comboBox
            Layout.rightMargin: (Styles.toolBar.height - textField.height)/2
            Layout.preferredWidth: parent.width * 0.3
            Layout.alignment: Qt.AlignVCenter
            model: [qsTr("Все"), qsTr("В наличии"), qsTr("Отсутствуют")]
            font.pixelSize: Styles.font.small
            editable: false
            delegate: ItemDelegate {
                       id: itemDelegate
                       width: parent.width
                       text: comboBox.textRole ? (Array.isArray(comboBox.model) ? modelData[comboBox.textRole] : model[comboBox.textRole]) : modelData
                       font.pixelSize: Styles.font.small

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
               text: comboBox.displayText
               font: comboBox.font
               color: "white"
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignRight
               elide: Text.ElideRight
           }
           onCurrentIndexChanged: {
               colorBasePage.update();
           }
        }
    }
}


