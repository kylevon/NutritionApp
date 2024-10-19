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
            text: "Health Information"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        // Helper component for required fields
        Component {
            id: requiredFieldLabel
            Text {
                text: "*"
                color: "red"
                font.pixelSize: 16
                font.bold: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            TextField {
                id: ageField
                placeholderText: "Age"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 16
                leftPadding: 20
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator { bottom: 1; top: 120 }
                background: Rectangle {
                    radius: 25
                    border.color: ageField.activeFocus ? "blue" : "lightgray"
                    border.width: 2
                }
            }
            Loader { sourceComponent: requiredFieldLabel }
        }

        RowLayout {
            Layout.fillWidth: true
            TextField {
                id: weightField
                placeholderText: "Weight (kg)"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 16
                leftPadding: 20
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: DoubleValidator { bottom: 1.0; top: 300.0; decimals: 1 }
                background: Rectangle {
                    radius: 25
                    border.color: weightField.activeFocus ? "blue" : "lightgray"
                    border.width: 2
                }
            }
            Loader { sourceComponent: requiredFieldLabel }
        }

        RowLayout {
            Layout.fillWidth: true
            TextField {
                id: heightField
                placeholderText: "Height (cm)"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 16
                leftPadding: 20
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: IntValidator { bottom: 1; top: 300 }
                background: Rectangle {
                    radius: 25
                    border.color: heightField.activeFocus ? "blue" : "lightgray"
                    border.width: 2
                }
            }
            Loader { sourceComponent: requiredFieldLabel }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            ComboBox {
                id: genderComboBox
                model: ["Select Gender (?)", "Cis Male", "Cis Female", "Trans Male", "Trans Female", "Other"]
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 16
                leftPadding: 20
                rightPadding: 20
                background: Rectangle {
                    radius: 25
                    border.color: genderComboBox.activeFocus ? "blue" : "lightgray"
                    border.width: 2
                }
                popup: Popup {
                    y: genderComboBox.height - 1
                    width: genderComboBox.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 1

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: genderComboBox.popup.visible ? genderComboBox.delegateModel : null
                        currentIndex: genderComboBox.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    background: Rectangle {
                        border.color: "lightgray"
                        radius: 2
                    }
                }
            }

            Text {
                text: "?"
                font.pixelSize: 18
                font.bold: true
                color: "blue"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: genderTooltip.visible = !genderTooltip.visible
                }

                ToolTip {
                    id: genderTooltip
                    text: "Cis: A person whose gender identity matches their sex assigned at birth.\n\nTrans: A person whose gender identity differs from their sex assigned at birth."
                    visible: false
                    delay: 0
                    timeout: 5000
                    contentItem: Text {
                        text: genderTooltip.text
                        color: "white"
                        wrapMode: Text.Wrap
                    }
                    background: Rectangle {
                        color: "#333333"
                        radius: 5
                    }
                }
            }
            Loader { sourceComponent: requiredFieldLabel }
        }

        RowLayout {
            Layout.fillWidth: true
            visible: genderComboBox.currentText === "Other"
            TextField {
                id: otherGenderField
                placeholderText: "Specify gender"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 16
                leftPadding: 20
                background: Rectangle {
                    radius: 25
                    border.color: otherGenderField.activeFocus ? "blue" : "lightgray"
                    border.width: 2
                }
            }
            Loader { sourceComponent: requiredFieldLabel }
        }

        RowLayout {
            Layout.fillWidth: true
            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                clip: true

                TextArea {
                    id: healthConditionsArea
                    placeholderText: "Describe your health conditions..."
                    wrapMode: TextArea.Wrap
                    font.pixelSize: 16
                    background: Rectangle {
                        radius: 25
                        border.color: healthConditionsArea.activeFocus ? "blue" : "lightgray"
                        border.width: 2
                    }
                }
            }
            Loader { sourceComponent: requiredFieldLabel }
        }

        Button {
            id: submitFormButton
            text: "Submit Form"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            background: Rectangle {
                color: submitFormButton.hovered ? Qt.darker("blue", 1.2) : "blue"
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
                if (isFormValid()) {
                    // Add form submission logic here
                    console.log("Form submitted successfully")
                } else {
                    console.log("Please fill in all required fields")
                    highlightInvalidFields()
                }
            }

            // Add a scale effect on hover
            scale: submitFormButton.hovered ? 1.05 : 1
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        // Spacer
        Item { Layout.fillHeight: true }
    }

    function isFormValid() {
        return ageField.acceptableInput &&
               weightField.acceptableInput &&
               heightField.acceptableInput &&
               genderComboBox.currentIndex !== 0 &&
               (genderComboBox.currentText !== "Other" || otherGenderField.text !== "") &&
               healthConditionsArea.text !== ""
    }

    function highlightInvalidFields() {
        ageField.background.border.color = ageField.acceptableInput ? "lightgray" : "red"
        weightField.background.border.color = weightField.acceptableInput ? "lightgray" : "red"
        heightField.background.border.color = heightField.acceptableInput ? "lightgray" : "red"
        genderComboBox.background.border.color = genderComboBox.currentIndex !== 0 ? "lightgray" : "red"
        if (genderComboBox.currentText === "Other") {
            otherGenderField.background.border.color = otherGenderField.text !== "" ? "lightgray" : "red"
        }
        healthConditionsArea.background.border.color = healthConditionsArea.text !== "" ? "lightgray" : "red"
    }
}