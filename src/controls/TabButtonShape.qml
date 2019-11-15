import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.12
import Styles 1.0
import Units 1.0

Item {
    property alias color: trap.fillColor
    Shape {
        id: shape
        anchors {
            bottom: parent.bottom
            fill: parent
        }
        ShapePath {
            id: trap
            fillColor: Styles.colorTheme.notActive
            strokeColor: fillColor
            strokeWidth: 1
            strokeStyle: ShapePath.SolidLine
            joinStyle: ShapePath.RoundJoin
            startX: 0; startY: Styles.tabButton.height
            PathLine { x: Styles.tabButton.height; y: 0 }
            PathLine { x: Styles.tabButton.width - Styles.tabButton.height; y: 0 }
            PathLine { x: Styles.tabButton.width; y: Styles.tabButton.height }

        }
        ShapePath {
            strokeColor: Styles.colorTheme.active
            strokeWidth: 1
            startX: Units.dp(0); startY: Units.dp(35)
            PathLine { x: Units.dp(170); y: Units.dp(35) }
        }
    }
}
