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
            text: "Sign In"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
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

        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            font.pixelSize: 16
            leftPadding: 20
            background: Rectangle {
                radius: 25
                border.color: passwordField.activeFocus ? "blue" : "lightgray"
                border.width: 2
            }
        }

        Button {
            id: signInButton
            text: "Sign In"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            background: Rectangle {
                color: signInButton.hovered ? Qt.darker("blue", 1.2) : "blue"
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
                // Add sign in logic here
                // For now, we'll just navigate to the new view
                stackView.push(nutritionAndMedicationClocksView)
            }

            // Add a scale effect on hover
            scale: signInButton.hovered ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        Text {
            id: forgotPasswordLink
            text: "<u>Forgot Password?</u>"
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10

            MouseArea {
                id: forgotPasswordArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: stackView.push(forgotPasswordView)
            }

            color: forgotPasswordArea.containsMouse ? "blue" : "black"
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            scale: forgotPasswordArea.containsMouse ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        Text {
            id: createAccountLink
            text: "Don't have an account? <b>Create one</b>"
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20

            MouseArea {
                id: createAccountArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: stackView.push(accountCreationView)
            }

            color: createAccountArea.containsMouse ? "blue" : "black"
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            scale: createAccountArea.containsMouse ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        // Spacer
        Item { Layout.fillHeight: true }
    }
}
