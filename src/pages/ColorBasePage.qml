import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"
import "../table_controls"
import "../utils/Database.js" as DB

Page {
    property alias flossModel: tabBarRepeater.model
    TabBar {
        property TabButton prevItem: currentItem

        id: tabBar
        z: 2
        contentWidth: parent.width
        width: parent.width
        height: Styles.tabButton.height
        background: Rectangle {
            anchors.fill: parent
            color: Styles.colorTheme.background
        }
        Repeater {
            id: tabBarRepeater
            model: ListModel {}
            TriangularTabButton {
                buttonText: name
                brand_id: id
            }
        }
        onCurrentItemChanged: {
            if (prevItem != null) {
                prevItem.color = Styles.colorTheme.notActive;
            }
            if (currentItem != null) {
                currentItem.color = Styles.colorTheme.active;
                prevItem = currentItem;
            }
        }
    }

    StackLayout {
        id: tabs
        anchors.top: tabBar.bottom
        width: parent.width
        height: parent.height - Styles.table.headerHeight - Styles.tabButton.height
        currentIndex: tabBar.currentIndex
        Repeater {
            id: tabRepeater
            model: flossModel
            FlossTableView {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.height
                width: parent.width
                brand: id
                brandName: name
            }
        }

    }

    Component.onCompleted: {
        DB.init();
        DB.fillDatabase();
        createTables();
    }
    function createTables() {
        var brands = DB.getBrandsInStock();
        flossModel.append(brands);
        update();
    }
    function update() {
        for (var i = 0; i < tabs.count; i++) {
            tabs.itemAt(i).fillTable();
        }
    }
    function addBrand(item) {
        flossModel.append(item);
        tabs.itemAt(tabs.count - 1).fillTable();
    }
    function deleteBrand(id) {
        for (var i = 0; i < flossModel.count; i++) {
            if (flossModel.get(i).id === id) {
                if (tabBar.currentIndex === 0 && i === 0 && flossModel.count > 1) {
                    tabBar.itemAt(1).color = Styles.colorTheme.active;
                    tabBar.prevItem = tabBar.itemAt(1);
                }
                flossModel.remove(i);
                return;
            }
        }
    }
}
