import QtQuick
import QtQuick.Controls

Button {
    id: root
    property string iconSource
    property color iconColor: "#007AFF"  // iOS-style blue
    property color textColor: "#007AFF"
    property bool isActive: false

    background: Rectangle {
        color: "transparent"
    }

    contentItem: Column {
        spacing: 4
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 24
            height: 24

            Image {
                id: icon
                anchors.fill: parent
                source: root.iconSource
                visible: false
            }

            ShaderEffect {
                anchors.fill: icon
                property variant src: icon
                property color color: root.iconColor

                fragmentShader: "
                    varying highp vec2 qt_TexCoord0;
                    uniform sampler2D src;
                    uniform highp vec4 color;
                    void main() {
                        highp vec4 tex = texture2D(src, qt_TexCoord0);
                        gl_FragColor = vec4(color.rgb, tex.a);
                    }
                "
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.text
            font.pixelSize: 12
            color: root.textColor
        }
    }

    states: [
        State {
            name: "pressed"
            when: root.pressed
            PropertyChanges {
                target: root
                iconColor: Qt.darker(root.iconColor, 1.2)
                textColor: Qt.darker(root.textColor, 1.2)
            }
        },
        State {
            name: "active"
            when: root.isActive
            PropertyChanges {
                target: root
                iconColor: "#007AFF"
                textColor: "#007AFF"
            }
        },
        State {
            name: "inactive"
            when: !root.isActive
            PropertyChanges {
                target: root
                iconColor: "#8E8E93"  // Light gray for inactive state
                textColor: "#8E8E93"
            }
        }
    ]
}
