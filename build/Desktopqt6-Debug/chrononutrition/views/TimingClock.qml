import QtQuick
import QtQuick.Shapes

Item {
    id: root
    width: 300
    height: 300

    property var timeRanges: []
    property string supplementName: ""
    property date currentTime: new Date()

    Shape {
        id: clockFace
        anchors.fill: parent
        antialiasing: true
        
        // Outer circle
        ShapePath {
            strokeColor: "black"
            strokeWidth: 2
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width / 2 - 10
                radiusY: root.height / 2 - 10
                startAngle: 0
                sweepAngle: 360
            }
        }

        // Inner circle (to create the ring)
        ShapePath {
            strokeColor: "black"
            strokeWidth: 2
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width / 2 - 30
                radiusY: root.height / 2 - 30
                startAngle: 0
                sweepAngle: 360
            }
        }
    }

    // 12 dots for hours
    Repeater {
        model: 12
        delegate: Rectangle {
            width: 6
            height: 6
            radius: 3
            color: "black"
            x: root.width / 2 + Math.cos((index * 30 - 90) * Math.PI / 180) * (root.width / 2 - 20) - width / 2
            y: root.height / 2 + Math.sin((index * 30 - 90) * Math.PI / 180) * (root.height / 2 - 20) - height / 2
            antialiasing: true
        }
    }

    // Time ranges
    Repeater {
        model: timeRanges
        delegate: Shape {
            anchors.fill: parent
            antialiasing: true
            ShapePath {
                strokeColor: "transparent"
                fillColor: "#80008000"  // Green with 50% opacity
                capStyle: ShapePath.RoundCap

                PathMove {
                    x: root.width / 2 + Math.cos((modelData.start * 15 - 90) * Math.PI / 180) * (root.width / 2 - 30)
                    y: root.height / 2 + Math.sin((modelData.start * 15 - 90) * Math.PI / 180) * (root.height / 2 - 30)
                }

                PathArc {
                    x: root.width / 2 + Math.cos((modelData.end * 15 - 90) * Math.PI / 180) * (root.width / 2 - 30)
                    y: root.height / 2 + Math.sin((modelData.end * 15 - 90) * Math.PI / 180) * (root.height / 2 - 30)
                    radiusX: root.width / 2 - 30
                    radiusY: root.height / 2 - 30
                    useLargeArc: (modelData.end - modelData.start + 24) % 24 > 12
                }

                PathLine {
                    x: root.width / 2 + Math.cos((modelData.end * 15 - 90) * Math.PI / 180) * (root.width / 2 - 10)
                    y: root.height / 2 + Math.sin((modelData.end * 15 - 90) * Math.PI / 180) * (root.height / 2 - 10)
                }
            }
        }
    }

    // Current time hand
    Rectangle {
        id: currentTimeHand
        width: 2
        height: root.height / 2 - 30
        color: "red"
        anchors.bottom: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        transformOrigin: Item.Bottom
        rotation: (currentTime.getHours() % 12 + currentTime.getMinutes() / 60) * 30
        antialiasing: true
    }

    Text {
        id: supplementNameText
        anchors.centerIn: parent
        text: supplementName
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: nextIngestionText
        anchors.top: supplementNameText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: getNextIngestionText()
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        width: parent.width - 40
    }

    function updateClock() {
        currentTime = new Date()
        nextIngestionText.text = getNextIngestionText()
    }

    function getNextIngestionText() {
        if (timeRanges.length === 0) return ""

        let currentHour = currentTime.getHours() + currentTime.getMinutes() / 60
        let nextIngestion = timeRanges[0].start
        let minDiff = 24

        for (let range of timeRanges) {
            let diff = (range.start - currentHour + 24) % 24
            if (diff < minDiff) {
                minDiff = diff
                nextIngestion = range.start
            }
        }

        let hoursUntil = Math.floor(minDiff)
        let minutesUntil = Math.round((minDiff - hoursUntil) * 60)

        return `${hoursUntil}h ${minutesUntil}m\nuntil next\n${supplementName}`
    }

    Timer {
        interval: 60000  // Update every minute
        running: true
        repeat: true
        onTriggered: updateClock()
    }

    Component.onCompleted: {
        updateClock()
    }
}