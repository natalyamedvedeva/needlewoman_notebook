import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0

Button {
    id: button
    property alias btext: text.text

    background: Rectangle {
        id: rec
        color: Styles.colorTheme.background
        anchors.fill: parent
    }
    Text {
        id: text
        font.pixelSize: Styles.font.normal
        font.family: Styles.font.family
        color: "white"
        anchors.centerIn: rec
    }
}
