import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "white"
    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Item { Layout.fillHeight: true }

        Text {
            text: "MiChro"
            font.pixelSize: 36
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }

        Button {
            id: getStartedButton
            text: "Get Started"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            background: Rectangle {
                color: getStartedButton.hovered ? Qt.darker("blue", 1.2) : "blue"
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
            onClicked: stackView.push(getStartedView)

            // Add a scale effect on hover
            scale: getStartedButton.hovered ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }

            // Add a cursor change on hover
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: getStartedButton.clicked()
            }
        }

        Text {
            id: signInText
            text: "Already a member? <b>Sign in</b>"
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 20
            color: signInArea.containsMouse ? "blue" : "black"
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            scale: signInArea.containsMouse ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }

            MouseArea {
                id: signInArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: stackView.push(signInView)
            }
        }
    }
}
