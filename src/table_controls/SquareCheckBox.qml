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
        Image {
            visible: parent.parent.checked
            source: "../resources/check.svg"
            sourceSize.height: parent.height
            sourceSize.width: height
            x: 0
            y: 0
        }
    }
}
