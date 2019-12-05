import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"
import "../table_controls"
import "../utils/Database.js" as DB

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
            id: tabBarRepeater
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
        Repeater {
            id: tabRepeater
            model: ListModel {}
            FlossTableView {
                id: tableView
                Layout.preferredHeight: parent.parent.height
                Layout.preferredWidth: parent.width
                width: parent.width
                model: ListModel {}
                Component.onCompleted: {
                    model.append(DB.getFlossWithBrand(modelData))
                }
            }
        }

    }
    function fillTables() {
        var brands = DB.getBrandsInStock();
        tabBarRepeater.model = brands.map(function(x) { return x.name; });
        tabRepeater.model = brands.map(function(x) { return x.id; });

    }
}
