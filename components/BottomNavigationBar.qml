import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    width: parent.width
    height: 60

    signal inputClicked()
    signal reviewClicked()

    Rectangle {
        anchors.fill: parent
        color: "#FFFFFF"  // Background color of the navigation bar

        RowLayout {
            anchors.fill: parent
            spacing: 10
            anchors.margins: 10

            // Input Button
            Button {
                id: inputButton
                text: "Input"
                Layout.fillWidth: true
                background: Rectangle {
                    color: "#007AFF"  // Blue color
                    radius: 10
                }
                contentItem: Text {
                    text: inputButton.text
                    color: "#FFFFFF"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: root.inputClicked()
            }

            // Review Button
            Button {
                id: reviewButton
                text: "Review"
                Layout.fillWidth: true
                background: Rectangle {
                    color: "#007AFF"  // Blue color
                    radius: 10
                }
                contentItem: Text {
                    text: reviewButton.text
                    color: "#FFFFFF"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: root.reviewClicked()
            }
        }
    }
}
