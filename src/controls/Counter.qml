import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0

Row {
    property int value: quantity
    spacing: height * 0.1
    anchors.horizontalCenter: parent.horizontalCenter
    CircleButton {
        btext: "–"
        radius: parent.height
        onClicked: {
            value = value - 1
        }
        enabled: value > 0
        anchors.verticalCenter: parent.verticalCenter
    }
    Label {
        text: value
        anchors.verticalCenter: parent.verticalCenter
        width: parent.height
        horizontalAlignment: Label.AlignHCenter
        font.pixelSize: Styles.font.normal
        font.family: Styles.font.family
    }
    CircleButton {
        btext: "+"
        radius: parent.height
        onClicked:  {
            value = value + 1
        }
        anchors.verticalCenter: parent.verticalCenter
    }
}
