import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "white"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Back button
        Button {
            id: backButton
            Layout.topMargin: 20
            Layout.leftMargin: 20
            text: "<"
            contentItem: Text {
                text: backButton.text
                font.pixelSize: 24
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 40
                radius: 20
                color: backButton.hovered ? "#f0f0f0" : "white"
                border.color: "black"
                border.width: 1
            }
            onClicked: stackView.pop()
        }

        // Spacer
        Item { Layout.fillHeight: true }

        // Centered content
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            // Title
            Text {
                text: "Log Nutrient Intake"
                font.pixelSize: 28  // Increased from 24 to 28
                font.weight: Font.Bold  // Changed from Font.Light to Font.Bold
                Layout.alignment: Qt.AlignHCenter
            }

            // Placeholder image
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 200
                height: 200
                color: "lightgray"

                Text {
                    anchors.centerIn: parent
                    text: "Placeholder Image"
                    color: "gray"
                }
            }

            // Caption
            Text {
                id: captionText
                text: "Track your intake and customize your meal plan to meet your goals."
                wrapMode: Text.Wrap
                width: parent.width * 0.97
                Layout.preferredWidth: parent.width * 0.97
                Layout.maximumWidth: parent.width * 0.97
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                elide: Text.ElideRight
            }
        }

        // Spacer
        Item { Layout.fillHeight: true }

        // Progress dots
        Row {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter
            Repeater {
                model: 3
                Rectangle {
                    width: 10
                    height: 10
                    radius: 5
                    color: index === 0 ? "blue" : "lightgray"
                }
            }
        }

        // Continue button
        Button {
            id: continueButton
            text: "Continue"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            background: Rectangle {
                color: continueButton.hovered ? Qt.darker("lightblue", 1.1) : "lightblue"
                radius: 25
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }
            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: stackView.push(personalisedRecommendationsView)

            // Hover effect
            scale: continueButton.hovered ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }

            // Add a cursor change on hover
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: continueButton.clicked()
            }
        }
    }
}
