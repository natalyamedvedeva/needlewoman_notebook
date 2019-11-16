import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0

CheckBox {
    height: 30
    width: height
    indicator: Rectangle {
        implicitWidth: parent.height
        implicitHeight: parent.height
        border.color: "black"
        Rectangle {
            width: parent.width / 2
            height: parent.height / 2
            x: parent.width / 4
            y: parent.height / 4
            color: parent.border.color
            visible: parent.parent.checked
        }
    }
}
