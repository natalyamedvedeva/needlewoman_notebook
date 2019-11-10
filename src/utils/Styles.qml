pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import Units 1.0

QtObject {
    property QtObject toolBar: QtObject {
        property int height: Units.dp(60)
    }

    property QtObject toolButton: QtObject {
        property int height: Units.dp(57)
    }

    property QtObject tabButton: QtObject {
        property int height: Units.dp(50)
        property int width: Units.dp(210)
    }

    property QtObject appWindow: QtObject {
        property int height: 640
        property int width: 360
    }

    property QtObject colorTheme: QtObject {
        property string background: "#FA8072"
        property string notActive: "#f5ebeb"
        property string active: "white"
    }

}

