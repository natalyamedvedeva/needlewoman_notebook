import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"

Page {
    TabBar {
        property int prevCurrentIndex: 0
        id: tabBar
        contentWidth: parent.width
        width: parent.width
        height: Styles.tabButton.height
        background: Rectangle {
                        anchors {
                            fill: parent
                        }
                        color: Styles.colorTheme.background
                    }
        Repeater {
            model: ["Gamma", "DMC", "ПНК"]

            TriangularTabButton {
                buttonText: modelData
            }
        }
        onCurrentIndexChanged: {
            itemAt(prevCurrentIndex).color = Styles.colorTheme.notActive;
            currentItem.color = Styles.colorTheme.active;
            prevCurrentIndex = currentIndex;
        }
    }
}
