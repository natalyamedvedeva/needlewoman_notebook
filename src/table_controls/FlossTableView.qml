import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0

Item {
    property alias model: list.model
    TableHeader {
        id: header
        z: 3
        width: parent.width
    }

    FlossListView {
        anchors.top: header.bottom
        id: list
        width: parent.width
        height: parent.height - header.height - Styles.tabButton.height
        ScrollBar.vertical: ScrollBar{}
    }
}
