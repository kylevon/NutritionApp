pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Item {
    id: root
    anchors.fill: parent

    // Assuming stackView is defined in a parent component and passed in
    property var stackView

    // Model for the ListView
    ListModel {
        id: nutrientModel
    }

    // Function to fetch data
    function fetchNutrientData() {
        var dummyNutrients = [
            "Calories", "Protein", "Fats", "Omega3", "Omega6", "BCAA",
            "Saturated Fats", "Monounsaturated Fats", "Polyunsaturated Fats",
            "Trans Fats", "Carbohydrates", "Sugars", "Starches", "Fiber"
        ];

        nutrientModel.clear();
        for (var i = 0; i < dummyNutrients.length; i++) {
            var quantity = Math.random() * 100;
            var daily_recommended = Math.random() * 100 + 50;
            var toxic_amount = daily_recommended * (Math.random() * 2 + 2);
            
            nutrientModel.append({
                nutrient_name: dummyNutrients[i],
                quantity: quantity,
                unit: "g",
                daily_recommended: daily_recommended,
                toxic_amount: toxic_amount
            });
        }
    }

    Component.onCompleted: fetchNutrientData()

    ListView {
        id: nutrientListView
        anchors.fill: parent
        anchors.bottomMargin: bottomNav.height + feedbackButton.height + 20
        model: nutrientModel
        delegate: nutrientDelegate
        spacing: 10
    }

    Button {
        id: feedbackButton
        text: "Give me feedback"
        anchors.bottom: bottomNav.top
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            // Navigate to feedback view
            root.stackView.push("FeedbackView.qml")
        }
    }

    BottomNavigationBar {
        id: bottomNav
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }

    // Delegate component for each nutrient item
    Component {
        id: nutrientDelegate

        Rectangle {
            width: nutrientListView.width
            height: 100
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: nutrientListView.model.nutrient_name
                    font.bold: true
                    Layout.preferredWidth: parent.width * 0.2
                }

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20

                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"

                        Rectangle {
                            width: (nutrientListView.model.quantity / nutrientListView.model.toxic_amount) * parent.width
                            height: parent.height
                            color: nutrientListView.model.quantity > nutrientListView.model.daily_recommended ? "orange" : "green"
                        }

                        Rectangle {
                            x: (nutrientListView.model.daily_recommended / nutrientListView.model.toxic_amount) * parent.width - 1
                            width: 2
                            height: parent.height
                            color: "blue"
                        }

                        Rectangle {
                            x: parent.width - 2
                            width: 2
                            height: parent.height
                            color: "red"
                        }
                    }

                    Text {
                        anchors.top: parent.bottom
                        text: nutrientListView.model.quantity.toFixed(2) + " " + nutrientListView.model.unit
                    }
                }

                Button {
                    text: "?"
                    onClicked: {
                        // Navigate to info page for this nutrient
                        root.stackView.push("NutrientInfoView.qml", { nutrientName: nutrientListView.model.nutrient_name })
                    }
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                }
            }
        }
    }
}
