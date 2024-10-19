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
            text: "Create an account"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: fullNameField
            placeholderText: "Full name"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            font.pixelSize: 16
            leftPadding: 20
            background: Rectangle {
                radius: 25
                border.color: fullNameField.activeFocus ? "blue" : "lightgray"
                border.width: 2
            }
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
            id: createAccountButton
            text: "Create Account"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            background: Rectangle {
                color: createAccountButton.hovered ? Qt.darker("blue", 1.2) : "blue"
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
                // Add account creation logic here
                // After successful account creation, navigate to the HealthConditionForm
                stackView.push(healthConditionForm)
            }

            // Add a scale effect on hover
            scale: createAccountButton.hovered ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        Text {
            id: disclaimerText
            text: 'By clicking "Create Account", you agree to MiChro\'s <u>Terms of Use</u>'
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.8
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter

            MouseArea {
                id: termsArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Add navigation to Terms of Use page here
                }
            }

            color: termsArea.containsMouse ? "blue" : "black"
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            scale: termsArea.containsMouse ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        Text {
            id: signInLink
            text: "Already have an account? <b>Sign in</b>"
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
