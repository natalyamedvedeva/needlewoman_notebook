import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Row {
    property int value: 0
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
