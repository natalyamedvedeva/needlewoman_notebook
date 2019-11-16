import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"
import "../table_controls"

Page {
    TabBar {
        property int prevCurrentIndex: 0
        id: tabBar
        z: 2
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

    StackLayout {
        anchors.top: tabBar.bottom
        width: parent.width
        height: parent.height
        currentIndex: tabBar.currentIndex
        FlossTableView {
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            width: parent.width
            model: ListModel {
                ListElement {
                    number: "0001"
                    available: true
                    quantity: 9
                    name: "синий синий синий синий"
                    flossColor: "blue"
                }
                ListElement {
                    number: "0002"
                    available: false
                    quantity: 0
                    name: "красный красный красный красный"
                    flossColor: "red"
                }
                ListElement {
                    number: "0003"
                    available: true
                    quantity: 2
                    name: "желтый желтый желтый желтый"
                    flossColor: "yellow"
                }
            }
        }
    }
}
