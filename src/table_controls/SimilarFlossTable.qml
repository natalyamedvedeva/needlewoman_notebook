import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../utils/Database.js" as DB

Item {
    property alias model: list.model
    property alias tableVisible: header.visible
    Item {
        z: 3
        id: header
        height: Styles.table.headerHeight
        width: parent.width
        visible: false
        Rectangle {
            id: background
            anchors.fill: parent
        }
        RowLayout {
            anchors.fill: parent

            TableCellText {
                Layout.preferredWidth: parent.width * 0.2
                color: Styles.font.tableHeaderColor
                text: qsTr("Производитель")
                elide: Text.ElideMiddle
            }
            TableCellText {
                Layout.preferredWidth: parent.width * Styles.table.numberWidth
                color: Styles.font.tableHeaderColor
                text: qsTr("Номер")
            }
            TableCellText {
                Layout.preferredWidth: parent.width * Styles.table.availableWidth
                color: Styles.font.tableHeaderColor
                text: qsTr("Наличие")
            }
            TableCellText {
                Layout.preferredWidth: parent.width * 0.24
                color: Styles.font.tableHeaderColor
                text: qsTr("Название")
            }
            TableCellText {
                Layout.preferredWidth: parent.width * Styles.table.colorWidth
                color: Styles.font.tableHeaderColor
                text: qsTr("Цвет")
            }
        }
    }
    ListView {
        id: list
        anchors.top: header.bottom
        width: parent.width
        height: parent.height
        model: ListModel{}
        delegate: Item {
            id: item
            height: Styles.table.rowHeight
            width: parent.width
            RowLayout {
                height: parent.height
                width: parent.width

                TableCellText {
                    Layout.preferredWidth: parent.width * 0.2
                    font.pixelSize: Styles.font.normal
                    text: brand
                }
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
                Text {
                    Layout.preferredWidth: parent.width * 0.24
                    Layout.fillWidth: true
                    font.pixelSize: Styles.font.normal
                    Layout.alignment: Qt.AlignCenter
                    font.family: Styles.font.family
                    clip: true
                    horizontalAlignment: Text.Left
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
}
