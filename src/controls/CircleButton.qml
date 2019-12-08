import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0

Button {
    id: button
    property alias radius: button.height
    property alias btext: text.text

    width: height
    background: Rectangle {
        id: rec
        radius: 80
        color: Styles.colorTheme.background
        anchors.fill: parent
    }
    Text {
        id: text
        font.pixelSize: Styles.font.large
        font.family: Styles.font.family
        color: "white"
        anchors.centerIn: rec
    }
}
