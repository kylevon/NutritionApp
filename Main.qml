import QtQuick
import QtQuick.Controls
import QtQuick.VirtualKeyboard

// Import your view files, not necessary for compilation, but
// for the IDE to find the files
import "views"
import "components"  // Add this import

Window {
    id: window
    width: 375
    height: 667
    minimumWidth: 375
    minimumHeight: 667
    maximumWidth: 375
    maximumHeight: 667
    visible: true
    title: qsTr("MiChro")

    // StackView to manage multiple views
    StackView {
        id: stackView
        anchors.fill: parent
        anchors.bottomMargin: bottomNav.visible ? bottomNav.height : 0
        initialItem: cameraInputView
        onCurrentItemChanged: window.updateBottomNavVisibility()
    }

    // Camera Input view component
    Component {
        id: cameraInputView
        CameraInputView {}  // Make sure you have this view created
    }

    // Nutrition Review view component
    Component {
        id: nutritionReviewView
        NutritionReviewView {}  // Changed from ReviewView to NutritionReviewView
    }

    // Welcome view component
    Component {
        id: welcomeView
        WelcomeView {}
    }

    // Get Started view component
    Component {
        id: getStartedView
        GetStartedView {}
    }

    // Sign In view component
    Component {
        id: signInView
        SignInView {}
    }

    // Personalized Recommendations view component
    Component {
        id: personalisedRecommendationsView
        PersonalisedRecommendationsView {}
    }

    // Account Creation view component
    Component {
        id: accountCreationView
        AccountCreationView {}
    }

    // Forgot Password view component
    Component {
        id: forgotPasswordView
        ForgotPasswordView {}
    }

    // Health Condition Form component
    Component {
        id: healthConditionForm
        HealthConditionForm {}
    }

    // Nutrition and Medication Clocks view component
    Component {
        id: nutritionAndMedicationClocksView
        NutritionAndMedicationClocksView {}
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            // PropertyChanges {
                // target: inputPanel
                // y: Qt.binding(function() { return window.height - inputPanel.height })
            // }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    // Add this at the end of the Window content
    BottomNavigationBar {
        id: bottomNav
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        visible: false  // Initially hidden

        onInputClicked: {
            stackView.replace(null, cameraInputView)
            window.updateBottomNavVisibility()
        }
        onReviewClicked: {
            stackView.push(nutritionReviewView)
            window.updateBottomNavVisibility()
        }
    }

    // Function to change views and control bottom nav visibility
    function changeView(view) {
        if (view === cameraInputView) {
            stackView.replace(null, view)
        } else {
            stackView.push(view)
        }
        window.updateBottomNavVisibility()
    }

    function updateBottomNavVisibility() {
        var currentItem = stackView.currentItem
        bottomNav.visible = !(currentItem === welcomeView ||
                              currentItem === getStartedView ||
                              currentItem === signInView ||
                              currentItem === personalisedRecommendationsView ||
                              currentItem === accountCreationView ||
                              currentItem === forgotPasswordView ||
                              currentItem === healthConditionForm ||
                              currentItem === nutritionAndMedicationClocksView)
    }

    Component.onCompleted: updateBottomNavVisibility()
}
