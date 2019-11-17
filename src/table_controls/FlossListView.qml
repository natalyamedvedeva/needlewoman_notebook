import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0

ListView {
    id: listView
    delegate: Item {
        id: item
        height: Styles.table.rowHeight
        width: parent.width
        RowLayout {
            height: parent.height
            width: parent.width
            TableCellText {
                Layout.preferredWidth: parent.width * Styles.table.numberWidth
                font.pixelSize: Styles.font.normal
                text: number
            }
            Rectangle {
                Layout.preferredWidth: parent.width * Styles.table.availableWidth
                Layout.preferredHeight: parent.height
                Layout.alignment: Qt.AlignCenter
                SquareCheckBox {
                    checked: quantity > 0
                    enabled: false
                    height: item.height * 0.47
                    anchors.centerIn: parent
                }
            }
            TableCellText {
                Layout.preferredWidth: parent.width * Styles.table.quantityWidth
                font.pixelSize: Styles.font.normal
                text: quantity
            }
            TableCellText {
                Layout.preferredWidth: parent.width * Styles.table.nameWidth
                font.pixelSize: Styles.font.normal
                text: name
            }
            Rectangle {
                Layout.preferredWidth: parent.width * Styles.table.colorWidth
                Layout.preferredHeight: parent.height
                Layout.alignment: Qt.AlignCenter
                Rectangle {
                    color: flossColor
                    width: parent.width * 0.7
                    height: parent.height * 0.8
                    anchors.centerIn: parent
                    border.color: "black"
                }
            }
        }
    }
}
