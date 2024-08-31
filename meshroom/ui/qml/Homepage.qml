import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as Controls1 // For SplitView
import QtQuick.Layouts 1.11
import Utils 1.0
import MaterialIcons 2.2
import Controls 1.0

Page {
    id: root

    onVisibleChanged: {
        logo.playing = false
        if (visible) {
            logo.playing = true
        }
    }

    Controls1.SplitView {
        id: splitView
        anchors.fill: parent


        ColumnLayout {
            id: leftColumn
            height: parent.height

            Layout.minimumWidth: 200
            Layout.maximumWidth: 400

            AnimatedImage {
                id: logo
                property var ratio: sourceSize.width / sourceSize.height

                Layout.fillWidth: true
                Layout.preferredHeight: width / ratio

                source: "../img/meshroom-anim-once.gif"
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                MaterialToolLabelButton {
                    id: manualButton
                    Layout.topMargin: 20
                    iconText: MaterialIcons.open_in_new
                    label: "Manual"
                    font.pointSize: 16
                    iconSize: 24
                    flat: true
                    leftPadding: 20
                    rightPadding: {
                        var padding = leftColumn.width - labelItem.width - iconItem.width - leftPadding
                        if (padding > 0 && padding < leftColumn.Layout.maximumWidth)
                            return padding
                        return 0
                    }

                    onClicked: Qt.openUrlExternally("https://meshroom-manual.readthedocs.io/en/latest")
                }

                MaterialToolLabelButton {
                    id: releaseNotesButton
                    iconText: MaterialIcons.open_in_new
                    label: "Release Notes"
                    font.pointSize: 16
                    iconSize: 24
                    flat: true
                    leftPadding: 20
                    rightPadding: {
                        var padding = leftColumn.width - labelItem.width - iconItem.width - leftPadding
                        if (padding > 0 && padding < leftColumn.Layout.maximumWidth)
                            return padding
                        return 0
                    }

                    onClicked: Qt.openUrlExternally("https://github.com/alicevision/Meshroom/blob/develop/CHANGES.md")
                }

                MaterialToolLabelButton {
                    id: websiteButton
                    iconText: MaterialIcons.open_in_new
                    label: "Website"
                    font.pointSize: 16
                    iconSize: 24
                    flat: true
                    leftPadding: 20
                    rightPadding: {
                        var padding = leftColumn.width - labelItem.width - iconItem.width - leftPadding
                        if (padding > 0 && padding < leftColumn.Layout.maximumWidth)
                            return padding
                        return 0
                    }

                    onClicked: Qt.openUrlExternally("https://alicevision.org/")
                }
            }

            ColumnLayout {
                id: sponsors
                Layout.fillWidth: true

                Rectangle {
                    // find better alternative
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Sponsors"
                    font.pointSize: 16
                }

                Image {
                    Layout.alignment: Qt.AlignHCenter
                    property var ratio: sourceSize.width / sourceSize.height

                    Layout.preferredWidth: leftColumn.width * 0.6
                    Layout.preferredHeight: width / ratio
                    source: "../img/technicolor-group_rgb_primary_col-rev.png"
                    smooth: true
                    mipmap: true

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Qt.openUrlExternally("https://www.technicolor.com/")
                    }
                }

                RowLayout {
                    id: brandsRow

                    Layout.leftMargin: leftColumn.width * 0.05
                    Layout.rightMargin: leftColumn.width * 0.05

                    Image {
                        property var ratio: sourceSize.width / sourceSize.height

                        Layout.fillWidth: true
                        Layout.preferredHeight: width / ratio
                        source: "../img/MPC_TG.png"
                        smooth: true
                        mipmap: true

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("https://www.mpcvfx.com/")
                        }
                    }

                    Image {
                        property var ratio: sourceSize.width / sourceSize.height

                        Layout.fillWidth: true
                        Layout.preferredHeight: width / ratio
                        source: "../img/MILL_TG.png"
                        smooth: true
                        mipmap: true

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("https://www.themill.com/")
                        }
                    }

                    Image {
                        property var ratio: sourceSize.width / sourceSize.height

                        Layout.fillWidth: true
                        Layout.preferredHeight: width / ratio
                        source: "../img/MIKROS_TG.png"
                        smooth: true
                        mipmap: true

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("https://www.mikrosanimation.com/")
                        }
                    }

                    Image {
                        property var ratio: sourceSize.width / sourceSize.height

                        Layout.fillWidth: true
                        Layout.preferredHeight: width / ratio
                        source: "../img/TechnicolorGames_TG.png"
                        smooth: true
                        mipmap: true

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("https://www.technicolorgames.com/")
                        }
                    }
                }

                MaterialToolLabelButton {
                    Layout.topMargin: 20
                    iconText: MaterialIcons.favorite
                    label: "Support AliceVision"
                    font.pointSize: 16
                    iconSize: 24
                    flat: true
                    leftPadding: {
                        var padding = (leftColumn.width - labelItem.width - iconItem.width - 5) / 2
                        if (padding > 0 && padding < leftColumn.Layout.maximumWidth)
                            return padding
                        return 0
                    }
                    rightPadding: leftPadding

                    onClicked: Qt.openUrlExternally("https://alicevision.org/association/#donate")
                }
            }
        }
        
        ColumnLayout {
            id: rightColumn

            TabPanel {
                id: tabPanel
                tabs: ["Pipelines", "Recent Projects"]

                font.pointSize: 16

                Layout.fillWidth: true
                Layout.fillHeight: true

                ListView {
                    id: pipelinesListView
                    visible: tabPanel.currentTab === 0

                    anchors.fill: parent
                    anchors.margins: 10

                    model: [{ "name": "New Empty Project", "path": null }].concat(MeshroomApp.pipelineTemplateFiles)

                    delegate: Button {
                        id: pipelineDelegate
                        padding: 10
                        width: pipelinesListView.width

                        contentItem: Label {
                            id: pipeline
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            text: modelData["name"]
                            font.pointSize: 10
                        }

                        Connections {
                            target: pipelineDelegate
                            function onClicked() {
                                // Open pipeline
                                mainStack.push("Application.qml")
                                _reconstruction.new(modelData["path"])
                            }
                        }
                    }
                }

                GridView {
                    id: gridView
                    visible: tabPanel.currentTab === 1
                    anchors.fill: parent
                    anchors.topMargin: cellHeight * 0.1

                    cellWidth: 200
                    cellHeight: cellWidth
                    anchors.margins: 10

                    model: MeshroomApp.recentProjectFiles

                    // Update grid item when corresponding thumbnail is computed
                    Connections {
                        target: ThumbnailCache
                        function onThumbnailCreated(imgSource, callerID) {
                            let item = gridView.itemAtIndex(callerID);  // item is an Image
                            if (item && item.source === imgSource) {
                                item.updateThumbnail()
                                return
                            }
                            // fallback in case the Image cellID changed
                            for (let idx = 0; idx < gridView.count; idx++) {
                                item = gridView.itemAtIndex(idx)
                                if (item && item.source === imgSource) {
                                    item.updateThumbnail()
                                }
                            }
                        }
                    }

                    delegate: Column {
                        id: projectContent

                        width: gridView.cellWidth
                        height: gridView.cellHeight

                        property var source: modelData["thumbnail"] ? Filepath.stringToUrl(modelData["thumbnail"]) : ""

                        function updateThumbnail() {
                            thumbnail.source = ThumbnailCache.thumbnail(source, gridView.currentIndex)
                        }

                        onSourceChanged: updateThumbnail()

                        Button {
                            id: projectDelegate
                            height: gridView.cellHeight * 0.95 - project.height
                            width: gridView.cellWidth * 0.9

                            ToolTip.visible: hovered
                            ToolTip.text: modelData["path"]

                            text: modelData["thumbnail"] ? "" : MaterialIcons.description

                            Image {
                                id: thumbnail
                                visible: modelData["thumbnail"]
                                cache: false
                                asynchronous: true

                                fillMode: Image.PreserveAspectCrop

                                width: projectDelegate.width
                                height: projectDelegate.height
                            }

                            BusyIndicator {
                                anchors.centerIn: parent
                                running: gridView.visible && modelData["thumbnail"] && thumbnail.status != Image.Ready
                                visible: running
                            }

                            Connections {
                                target: projectDelegate
                                function onClicked() {
                                    // Open project
                                    mainStack.push("Application.qml")
                                    if (_reconstruction.loadUrl(modelData["path"])) {
                                        MeshroomApp.addRecentProjectFile(modelData["path"])
                                    } else {
                                        MeshroomApp.removeRecentProjectFile(modelData["path"])
                                    }
                                }
                            }
                        }
                        Label {
                            id: project
                            anchors.horizontalCenter: projectDelegate.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            width: projectDelegate.width
                            elide: Text.ElideMiddle
                            text: Filepath.basename(modelData["path"])
                            maximumLineCount: 1
                            font.pointSize: 10
                        }
                    }
                }
            }
        }
    }
}