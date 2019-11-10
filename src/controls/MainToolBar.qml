import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0

ToolBar {
    width: parent.width
    height: Styles.toolBar.height
    background: Rectangle {
        anchors.fill: parent
        color: Styles.colorTheme.background
    }
    RowLayout {
        anchors.fill: parent
        ToolButton {
            height: Styles.toolButton.height
            icon.source: "../resources/menu_icon.svg"
            icon.color: "white"
            background: Rectangle {
                anchors.fill: parent
                color: Styles.colorTheme.background
            }
        }
        TextField {
            id: textField
            font.pointSize: 8
            font.family: "Open Sans"
            background: Rectangle {
            }
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            Layout.rightMargin: (Styles.toolBar.height - height)/2
            placeholderText: qsTr("Найти оттенок...")
        }
    }
}


