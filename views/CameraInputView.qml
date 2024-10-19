import QtQuick
import QtMultimedia
import QtQuick.Controls

Item {
    id: root
    anchors.fill: parent
    property bool showBottomNav: true

    Component.onCompleted: {
        console.log("CameraInputView loaded")
    }

    Camera {
        id: camera
        active: true  // Always keep the camera active

        onActiveChanged: console.log("Camera active:", active)
        onErrorOccurred: (error, errorString) => {
            console.error("Camera error:", errorString)
        }
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectCrop
    }

    CaptureSession {
        camera: camera
        videoOutput: videoOutput

        onVideoOutputChanged: console.log("CaptureSession videoOutput changed")
        onCameraChanged: console.log("CaptureSession camera changed")
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Capture"
        onClicked: {
            console.log("Capture button clicked")
            // Implement capture functionality here
        }
    }

    function start() {
        console.log("Starting camera")
        camera.active = true
        camera.start()
    }

    function stop() {
        console.log("Stopping camera")
        camera.stop()
        camera.active = false
    }
}
