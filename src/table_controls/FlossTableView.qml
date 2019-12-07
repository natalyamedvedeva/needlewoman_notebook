import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../utils/Database.js" as DB

Item {
    property alias model: list.model
    property int brand: 0
    TableHeader {
        id: header
        z: 3
        width: parent.width
    }

    FlossListView {
        anchors.top: header.bottom
        id: list
        model: ListModel{}
        width: parent.width
        height: parent.height
        ScrollBar.vertical: ScrollBar{}
    }
    function fillTable() {
        model.clear();
        model.append(DB.getSuitableFloss(brand, toolBar.available, toolBar.filter));
    }
}
