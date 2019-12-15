import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Styles 1.0
import Units 1.0
import "../controls"
import "../table_controls"
import "../utils/Database.js" as DB
import "../utils/RgbToLab.js" as RGB

Page {
    title: "Подбор похожих оттенков"
    topPadding: Units.dp(10)
    Column {
        anchors.fill: parent
        Row {
            width: parent.width * 0.9
            height: Units.dp(70)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: width * 0.1

            Column {
                height: parent.height
                width: parent.width * 0.45
                spacing: Units.dp(4)
                Label {
                    text: qsTr("Производитель")
                    font.pixelSize: Styles.font.small
                    font.family: Styles.font.family
                }

                ComboBox {
                    id: brandComboBox
                    width: parent.width
                    height: parent.height * 0.6
                    font.pixelSize: Styles.font.normal
                    font.family: Styles.font.family
                    model: ListModel{}
                    textRole: "name"
                    editable: false
                    delegate: ItemDelegate {
                       id: itemDelegate
                       width: parent.width
                       text: brandComboBox.textRole ? (Array.isArray(brandComboBox.model) ? modelData[brandComboBox.textRole] : model[brandComboBox.textRole]) : modelData
                       font.pixelSize: Styles.font.normal

                       contentItem: Label {
                           text: itemDelegate.text
                           font: itemDelegate.font
                           elide: Label.ElideRight
                           verticalAlignment: Label.AlignVCenter
                           horizontalAlignment: Label.AlignHCenter
                       }
                   }

                   indicator:Image {
                       id: icon
                       horizontalAlignment: Image.AlignRight
                       source: "../resources/arrow_black.svg";
                       sourceSize.height: parent.height
                       sourceSize.width: height
                       x: brandComboBox.width - sourceSize.height
                   }
                   contentItem: Text {
                       anchors.fill: parent
                       text: brandComboBox.displayText
                       font: brandComboBox.font
                       verticalAlignment: Text.AlignVCenter
                       horizontalAlignment: Text.AlignHCenter
                       elide: Text.ElideRight
                   }
                   Component.onCompleted: {
                       model.clear();
                       model.append(DB.getBrands());
                   }

                   onCurrentIndexChanged: {
                       numberComboBox.model.clear();
                       numberComboBox.model.append(DB.getFloss(model.get(currentIndex).id));
                   }
                }
            }
            Column {
                height: parent.height
                width: parent.width * 0.45
                spacing: Units.dp(4)
                Label {
                    text: qsTr("Номер")
                    font.pixelSize: Styles.font.small
                    font.family: Styles.font.family
                }

                ComboBox {
                    id: numberComboBox
                    width: parent.width
                    height: parent.height * 0.6
                    font.pixelSize: Styles.font.normal
                    font.family: Styles.font.family
                    model: ListModel{}
                    textRole: "number"
                    delegate: ItemDelegate {
                       id: itemDelegate2
                       width: parent.width
                       text: numberComboBox.textRole ? (Array.isArray(numberComboBox.model) ? modelData[numberComboBox.textRole] : model[numberComboBox.textRole]) : modelData
                       font.pixelSize: Styles.font.normal

                       contentItem: Label {
                           text: itemDelegate2.text
                           font: itemDelegate2.font
                           elide: Label.ElideRight
                           verticalAlignment: Label.AlignVCenter
                           horizontalAlignment: Label.AlignHCenter
                       }
                   }

                   indicator:Image {
                       horizontalAlignment: Image.AlignRight
                       source: "../resources/arrow_black.svg";
                       sourceSize.height: parent.height
                       sourceSize.width: height
                       x: numberComboBox.width - sourceSize.height
                   }
                   contentItem: Text {
                       anchors.fill: parent
                       text: numberComboBox.displayText
                       font: numberComboBox.font
                       verticalAlignment: Text.AlignVCenter
                       horizontalAlignment: Text.AlignHCenter
                       elide: Text.ElideRight
                   }
                   popup: Popup {
                           y: numberComboBox.height - 1
                           width: numberComboBox.width
                           implicitHeight: contentItem.implicitHeight
                           padding: 1

                           contentItem: ListView {
                               clip: true
                               implicitHeight: contentHeight
                               model: numberComboBox.popup.visible ? numberComboBox.delegateModel : null
                               currentIndex: numberComboBox.highlightedIndex

                               ScrollBar.vertical: ScrollBar { }
                           }

                           background: Rectangle {
                               border.color: Styles.colorTheme.notActive
                               radius: 2
                           }
                       }
                   onCurrentIndexChanged: {
                       if (currentIndex > -1) {
                           var similar = RGB.findSimilar(numberComboBox.model.get(numberComboBox.currentIndex).id, root.colors);
                           table.model.clear();
                           table.model.append(DB.getSimilarFlossInfo(similar));
                           table.tableVisible = true;
                       }
                   }
                }
          }
        }


        Row {
            height: parent.height
            width: parent.width
            SimilarFlossTable {
              id: table
              width: parent.width
              height: parent.height
            }
        }
    }
}
