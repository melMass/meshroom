import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

/**
 * MaterialToolLabel is a Label with an icon (using MaterialIcons).
 * It shows up its tooltip when hovered.
 */

Item {
    id: control
    property alias icon: iconItem
    property alias iconText: iconItem.text
    property alias iconSize: iconItem.font.pointSize
    property alias label: labelItem
    property alias labelIconRow: contentRow
    property var labelIconColor: palette.text
    property alias labelIconMouseArea: mouseArea
    property var labelWidth: undefined
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
    anchors.rightMargin: 5

    onLabelWidthChanged: {
        labelItem.width = labelWidth
    }

    RowLayout {
        id: contentRow
        Label {
            id: iconItem
            font.family: MaterialIcons.fontFamily
            font.pointSize: 13
            padding: 0
            text: ""
            color: control.labelIconColor
        }
        Label {
            id: labelItem
            text: ""
            color: control.labelIconColor
            width: control.labelWidth

            onWidthChanged: {
                if (control.labelWidth != undefined && width != control.labelWidth)
                    width = control.labelWidth
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
    ToolTip.visible: mouseArea.containsMouse
    ToolTip.delay: 500
}
