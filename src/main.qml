import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "controls"
import "pages"

ApplicationWindow {
    id:root
    visible: true
    width: 360
    height: 640
    title: qsTr("Блокнот вышивальщицы")

    header: MainToolBar {
        id: toolBar
        RowLayout {
            anchors.fill: parent
            ToolButton {
                height: Styles.toolButton.height
                icon.source: "../resources/menu_icon.svg"
                icon.color: "white"
                background: Rectangle {
                    anchors.fill: parent
                    color: toolBar.background.color
                }
            }
        }
    }

    StackView {
            id: stack
            initialItem: colorBasePage
            anchors.fill: parent
    }
    ColorBasePage {
        id: colorBasePage
        width: parent.width
    }
}
