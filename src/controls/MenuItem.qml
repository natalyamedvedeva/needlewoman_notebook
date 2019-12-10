import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0

ItemDelegate {
    font.pixelSize: Styles.font.normal
    font.family: Styles.font.family
    leftPadding: Units.dp(16)
    width: drawer.width
    height: Styles.menu.itemHeight
}
