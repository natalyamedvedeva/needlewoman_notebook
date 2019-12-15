import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import Styles 1.0
import Units 1.0
import "../pages"
import "../utils/RgbToLab.js" as RGB

ToolBar {
    property alias filter: searchTextField.text
    property alias available: comboBox.currentIndex
    property alias searchTextField: searchTextField
    property alias comboBox: comboBox
    property string pageTitle: ""
    width: parent.width
    height: Styles.toolBar.height
    background: Rectangle {
        anchors.fill: parent
        color: Styles.colorTheme.background
    }
    RowLayout {
        anchors.fill: parent
        ToolButton {
            Layout.leftMargin: (Styles.toolBar.height - searchTextField.height - width + icon.width)/2
            icon.source: stack.depth > 1 ? "../resources/back.svg" : "../resources/menu_icon.svg"
            icon.color: "white"
            background: Rectangle {
                anchors.fill: parent
                color: Styles.colorTheme.background
            }
            onClicked: {
                if (stack.depth > 1) {
                    stack.pop();
                } else {
                    menu.open();
                }
            }
        }

        TextField {
            id: searchTextField
            visible: stack.depth === 1
            font.pixelSize: Styles.font.normal
            inputMethodHints: Qt.ImhNoPredictiveText
            font.family: Styles.font.family
            selectByMouse: true
            background: Rectangle {
            }
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            placeholderText: qsTr("Найти оттенок...")
        }
        ComboBox {
            visible: stack.depth === 1
            id: comboBox
            Layout.rightMargin: (Styles.toolBar.height - searchTextField.height)/2
            Layout.preferredWidth: Units.dp(122)
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
               sourceSize.height: searchTextField.height
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
        }
        Text {
            id: pageName
            text: pageTitle
            visible: stack.depth > 1
            Layout.fillWidth: true
            color: "white"
            font.pixelSize: Styles.font.large
            font.family: Styles.font.family
            font.weight: Font.DemiBold
            Layout.alignment: Qt.AlignVCenter
        }
    }
}


