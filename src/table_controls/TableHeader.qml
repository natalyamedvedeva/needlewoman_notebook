import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0

Item {
    height: Styles.table.headerHeight
    width: parent.width
    Rectangle {
        id: background
        anchors.fill: parent
    }
    RowLayout {
        anchors.fill: parent
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
            Layout.preferredWidth: parent.width * Styles.table.quantityWidth
            color: Styles.font.tableHeaderColor
            text: qsTr("Кол-во")
        }
        TableCellText {
            Layout.preferredWidth: parent.width * Styles.table.nameWidth
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
