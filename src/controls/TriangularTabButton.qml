import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import Styles 1.0
import Units 1.0

TabButton {
    property alias buttonText: buttonText.text
    property alias color: background.color
    width: Styles.tabButton.width
    height: Styles.tabButton.height
    anchors.bottom: parent.bottom
    background:  TabButtonShape {
        id: background
    }
    Text {
        id: buttonText
        anchors {
            centerIn: parent
        }
        font.family: "Open Sans"
        font.pixelSize: Styles.font.normal
    }
}
