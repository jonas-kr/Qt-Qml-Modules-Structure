import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 760
    minimumWidth: 980
    minimumHeight: 620
    title: qsTr("Pulse // System monitoring")
    color: colors.canvas

    FontLoader {
        id: montserrat
        source: "qrc:/fonts/Montserrat.ttf"
    }

    QtObject {
        id: colors
        readonly property color canvas: "#111412"
        readonly property color panel: "#171b18"
        readonly property color panelRaised: "#1d231f"
        readonly property color line: "#2b332e"
        readonly property color muted: "#87918a"
        readonly property color text: "#e7ece8"
        readonly property color accent: "#c9f66d"
        readonly property color accentSoft: "#7eaa46"
        readonly property color cyan: "#72d8c3"
        readonly property color amber: "#efb968"
    }

    property int activeTab: 0

    ListModel {
        id: metricModel
        ListElement { label: "CPU usage"; value: "38.4"; unit: "%"; note: "Down 4.8% vs last hour"; tone: "#c9f66d" }
        ListElement { label: "Memory"; value: "12.6"; unit: "GB"; note: "of 32 GB available"; tone: "#72d8c3" }
        ListElement { label: "Temperature"; value: "54"; unit: "°C"; note: "Within normal range"; tone: "#efb968" }
    }

    Rectangle {
        anchors.fill: parent
        color: colors.canvas

        // Fine grid gives the dark canvas a subtle instrument-panel texture.
        Canvas {
            anchors.fill: parent
            opacity: 0.16
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "#718078"
                ctx.lineWidth = 1
                for (var x = 0; x < width; x += 44) {
                    ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, height); ctx.stroke()
                }
                for (var y = 0; y < height; y += 44) {
                    ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(width, y); ctx.stroke()
                }
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 24

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 218
                Layout.minimumWidth: 190
                radius: 18
                color: "#151916"
                border.color: colors.line
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 18
                    spacing: 0

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Rectangle {
                            width: 30; height: 30; radius: 9
                            color: colors.accent
                            Text { anchors.centerIn: parent; text: "P"; color: "#151a14"; font.pixelSize: 17; font.bold: true }
                        }
                        Text {
                            text: "PULSE"
                            color: colors.text
                            font.family: montserrat.name
                            font.pixelSize: 15
                            font.bold: true
                            font.letterSpacing: 2.5
                        }
                        Item { Layout.fillWidth: true }
                    }

                    Text {
                        Layout.topMargin: 48
                        text: "WORKSPACE"
                        color: colors.muted
                        font.family: montserrat.name
                        font.pixelSize: 10
                        font.letterSpacing: 1.5
                    }

                    ColumnLayout {
                        Layout.topMargin: 12
                        Layout.fillWidth: true
                        spacing: 5
                        Repeater {
                            model: ["Overview", "Processes", "Network", "Storage"]
                            delegate: Rectangle {
                                Layout.fillWidth: true
                                height: 42
                                radius: 10
                                color: index === window.activeTab ? "#293321" : "transparent"
                                border.color: index === window.activeTab ? "#536c36" : "transparent"
                                RowLayout {
                                    anchors.fill: parent; anchors.leftMargin: 12; anchors.rightMargin: 10
                                    spacing: 11
                                    Text { text: ["◈", "≡", "⌁", "▦"][index]; color: index === window.activeTab ? colors.accent : colors.muted; font.pixelSize: 17 }
                                    Text { text: modelData; color: index === window.activeTab ? colors.text : colors.muted; font.family: montserrat.name; font.pixelSize: 12; font.bold: index === window.activeTab }
                                    Item { Layout.fillWidth: true }
                                }
                                MouseArea { anchors.fill: parent; onClicked: window.activeTab = index }
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }
                    Rectangle { Layout.fillWidth: true; height: 1; color: colors.line }
                    RowLayout {
                        Layout.topMargin: 16
                        spacing: 10
                        Rectangle { width: 30; height: 30; radius: 9; color: "#303832"; Text { anchors.centerIn: parent; text: "AR"; color: colors.text; font.pixelSize: 10; font.bold: true } }
                        ColumnLayout { spacing: 1; Text { text: "Alex Rivera"; color: colors.text; font.family: montserrat.name; font.pixelSize: 11; font.bold: true } Text { text: "Administrator"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
                        Item { Layout.fillWidth: true }
                        Text { text: "···"; color: colors.muted; font.pixelSize: 17 }
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 22

                RowLayout {
                    Layout.fillWidth: true
                    Text { text: "Good morning, Alex"; color: colors.text; font.family: montserrat.name; font.pixelSize: 25; font.bold: true; font.letterSpacing: -0.5 }
                    Item { Layout.fillWidth: true }
                    Rectangle { width: 116; height: 34; radius: 9; color: colors.panel; border.color: colors.line; border.width: 1; Text { anchors.centerIn: parent; text: "⌁  LIVE"; color: colors.accent; font.family: montserrat.name; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1.2 } }
                    Text { text: "⋮"; color: colors.muted; font.pixelSize: 24; leftPadding: 8 }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 14
                    Repeater {
                        model: metricModel
                        delegate: Rectangle {
                            Layout.fillWidth: true; height: 128; radius: 14; color: colors.panel; border.color: colors.line; border.width: 1
                            ColumnLayout { anchors.fill: parent; anchors.margins: 18; spacing: 4; Text { text: label.toUpperCase(); color: colors.muted; font.family: montserrat.name; font.pixelSize: 10; font.letterSpacing: 1.1 } RowLayout { Layout.topMargin: 7; spacing: 6; Text { text: value; color: tone; font.family: montserrat.name; font.pixelSize: 30; font.bold: true } Text { text: unit; color: colors.muted; font.family: montserrat.name; font.pixelSize: 12 } } Text { text: note; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true; Layout.fillHeight: true; spacing: 14
                    Rectangle {
                        Layout.fillWidth: true; Layout.fillHeight: true; Layout.preferredWidth: 2; radius: 14; color: colors.panel; border.color: colors.line; border.width: 1
                        ColumnLayout { anchors.fill: parent; anchors.margins: 20; spacing: 0
                            RowLayout { Layout.fillWidth: true; Text { text: "CPU performance"; color: colors.text; font.family: montserrat.name; font.pixelSize: 14; font.bold: true } Item { Layout.fillWidth: true } Text { text: "Last 60 minutes  ▾"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
                            RowLayout { Layout.topMargin: 8; spacing: 7; Text { text: "38.4%"; color: colors.accent; font.family: montserrat.name; font.pixelSize: 24; font.bold: true } Text { text: "average"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
                            Item { Layout.fillHeight: true; Layout.fillWidth: true; Layout.topMargin: 18
                                Canvas { anchors.fill: parent; onWidthChanged: requestPaint(); onHeightChanged: requestPaint(); onPaint: { if (width <= 0 || height <= 0) return; var c = getContext("2d"); c.clearRect(0,0,width,height); c.strokeStyle="#2b332e"; c.lineWidth=1; for(var i=0;i<5;i++){var gy=i*height/4;c.beginPath();c.moveTo(0,gy);c.lineTo(width,gy);c.stroke()} c.strokeStyle="#c9f66d";c.lineWidth=2.5;c.beginPath(); for(var p=0;p<=width;p+=4){var t=p/width;var v=.46 + .11*Math.sin(t*18) + .07*Math.sin(t*43) + (t>.65 ? .05*Math.sin(t*80) : 0);var py=v*height; if(p===0)c.moveTo(p,py);else c.lineTo(p,py)} c.stroke(); c.fillStyle="#c9f66d";c.globalAlpha=.08;c.lineTo(width,height);c.lineTo(0,height);c.closePath();c.fill() } }
                            }
                            RowLayout { Layout.fillWidth: true; Layout.topMargin: 8; Text { text: "10:00"; color: colors.muted; font.pixelSize: 9 } Item { Layout.fillWidth: true } Text { text: "11:00"; color: colors.muted; font.pixelSize: 9 } }
                        }
                    }
                    ColumnLayout { Layout.fillWidth: true; Layout.fillHeight: true; Layout.preferredWidth: 1; spacing: 14
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; Layout.fillHeight: true; radius: 14; color: colors.panel; border.color: colors.line; border.width: 1
                            ColumnLayout { anchors.fill: parent; anchors.margins: 20; Text { text: "System health"; color: colors.text; font.family: montserrat.name; font.pixelSize: 14; font.bold: true } RowLayout { Layout.topMargin: 15; spacing: 14; Rectangle { width: 62; height: 62; radius: 31; color: "#293321"; border.color: colors.accent; border.width: 2; Text { anchors.centerIn: parent; text: "98"; color: colors.accent; font.pixelSize: 21; font.bold: true } } ColumnLayout { spacing: 4; Text { text: "Excellent"; color: colors.text; font.family: montserrat.name; font.pixelSize: 14; font.bold: true } Text { text: "All systems operational"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } } } Item { Layout.fillHeight: true } Text { text: "Last checked 12 seconds ago"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
                        }
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; Layout.fillHeight: true; radius: 14; color: colors.panel; border.color: colors.line; border.width: 1
                            ColumnLayout { anchors.fill: parent; anchors.margins: 20; Text { text: "Network activity"; color: colors.text; font.family: montserrat.name; font.pixelSize: 14; font.bold: true } RowLayout { Layout.topMargin: 13; spacing: 24; ColumnLayout { spacing: 4; Text { text: "↓  84.2"; color: colors.cyan; font.family: montserrat.name; font.pixelSize: 20; font.bold: true } Text { text: "MB/s download"; color: colors.muted; font.pixelSize: 10 } } ColumnLayout { spacing: 4; Text { text: "↑  12.8"; color: colors.amber; font.family: montserrat.name; font.pixelSize: 20; font.bold: true } Text { text: "MB/s upload"; color: colors.muted; font.pixelSize: 10 } } } Item { Layout.fillHeight: true } Text { text: "Ethernet · Connected"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
                        }
                    }
                }

                RowLayout { Layout.fillWidth: true; Text { text: "Updated just now"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } Item { Layout.fillWidth: true } Text { text: "v1.0.0  ·  Local session"; color: colors.muted; font.family: montserrat.name; font.pixelSize: 10 } }
            }
        }
    }
}
