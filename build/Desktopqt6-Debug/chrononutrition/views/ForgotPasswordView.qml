import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "white"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Back button
        Button {
            id: backButton
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

        Text {
            text: "Forgot Password"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Enter your email address and we'll send you a link to reset your password."
            wrapMode: Text.Wrap
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: emailField
            placeholderText: "Email"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            font.pixelSize: 16
            leftPadding: 20
            background: Rectangle {
                radius: 25
                border.color: emailField.activeFocus ? "blue" : "lightgray"
                border.width: 2
            }
        }

        Button {
            id: resetPasswordButton
            text: "Reset Password"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            background: Rectangle {
                color: resetPasswordButton.hovered ? Qt.darker("blue", 1.2) : "blue"
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
            onClicked: {
                // Add password reset logic here
            }

            // Add a scale effect on hover
            scale: resetPasswordButton.hovered ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        Text {
            id: signInLink
            text: "Remember your password? <b>Sign in</b>"
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20

            MouseArea {
                id: signInArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: stackView.push(signInView)
            }

            color: signInArea.containsMouse ? "blue" : "black"
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            scale: signInArea.containsMouse ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        // Spacer
        Item { Layout.fillHeight: true }
    }
}
