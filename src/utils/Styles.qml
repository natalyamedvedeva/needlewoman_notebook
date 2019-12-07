pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import Units 1.0

QtObject {
    property QtObject toolBar: QtObject {
        property int height: Units.dp(65)
    }

    property QtObject toolButton: QtObject {
        property int height: toolBar.height
    }

    property QtObject tabButton: QtObject {
        property int height: Units.dp(35)
        property int width: Units.dp(170)
    }

    property QtObject appWindow: QtObject {
        property int height: 640
        property int width: 360
    }

    property QtObject colorTheme: QtObject {
        property string background: "#FA8072"
        property string notActive: "#e8e8e8"
        property string active: "white"
    }

    property QtObject textField: QtObject {
        property int width: Units.dp(210)
    }

    property QtObject font: QtObject {
        property int normal: Units.dp(18)
        property int small: Units.dp(14)
        property int tiny: Units.dp(12)
        property string family: "Open Sans"
        property string tableHeaderColor: "#909090"
    }

    property QtObject table: QtObject {
        property int headerHeight: Units.dp(30)
        property int rowHeight: Units.dp(40)
        property real numberWidth: 0.16
        property real availableWidth: 0.14
        property real quantityWidth: 0.14
        property real nameWidth: 0.3
        property real colorWidth: 0.2
    }
}

