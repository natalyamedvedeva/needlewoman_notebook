import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "controls"
import "pages"
import "utils/Database.js" as DB

ApplicationWindow {
    property var colors: []

    id: root
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
    MenuPage {
        id: menu
    }

    ColorBasePage {
        id: colorBasePage
        Connections {
            target: toolBar.searchTextField
            onTextChanged: {
                colorBasePage.update();
            }
        }
        Connections {
            target: toolBar.comboBox
            onCurrentIndexChanged: {
                colorBasePage.update();
            }
        }
    }

    WorkerScript {
        id: worker
        source: "utils/RgbToLab.js"
        onMessage: colors = messageObject.reply
    }
    Component.onCompleted: {
        worker.sendMessage(DB.getColors());
    }
}
