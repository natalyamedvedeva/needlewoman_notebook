import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "controls"
import "pages"
import "utils/Database.js" as DB

ApplicationWindow {
    id:root
    visible: true
    width: 360
    height: 640
    title: qsTr("Блокнот вышивальщицы")

    header: MainToolBar {
        id: toolBar
    }
    StackView {
            id: stack
            initialItem: colorBasePage
            anchors.fill: parent
    }
    ColorBasePage {
        id: colorBasePage
        width: parent.width
    }
    Component.onCompleted: {
        DB.init();
        DB.fillDatabase();
    }
}
