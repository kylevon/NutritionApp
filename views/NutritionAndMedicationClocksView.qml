import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "white"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Nutrition and Medication Clock"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        TimingClock {
            id: vitaminDClock
            supplementName: "Vitamin D"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 300
            Layout.preferredHeight: 300
            timeRanges: [
                { start: 8, end: 10 },
                { start: 20, end: 22 }
            ]
        }

        Button {
            text: "Add New Supplement"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                // Add logic to create a new supplement clock
                console.log("Add new supplement clicked")
            }
        }

        // Spacer
        Item {
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: {
        // You can add any initialization logic here
    }
}
