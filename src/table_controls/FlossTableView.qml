import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../utils/Database.js" as DB

Item {
    property alias model: list.model
    property alias brandName: list.brandName
    property int brand: 0
    TableHeader {
        id: header
        z: 3
        width: parent.width
    }

    FlossListView {
        anchors.top: header.bottom
        id: list
        width: parent.width
        height: parent.height
        ScrollBar.vertical: ScrollBar{}
    }
    function fillTable() {
        model.clear();
        let data = DB.getSuitableFloss(brand, toolBar.available, toolBar.filter);
        for (let item of data) {
            model.append(item);
        }
    }
}
