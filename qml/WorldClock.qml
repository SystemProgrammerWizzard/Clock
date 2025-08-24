import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2 as Kirigami

Kirigami.ScrollablePage {
    title: qsTr("World Clock")
    
    // macOS-style light background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#F8F9FA" }
            GradientStop { position: 1.0; color: "#F5F5F7" }
        }
    }

    Timer {
        id: tick
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var currentTime = new Date()
            clockLabel.text = Qt.formatTime(currentTime, "hh:mm:ss")
            dateLabel.text = Qt.formatDate(currentTime, "dddd, MMMM d, yyyy")
            secondsLabel.text = Qt.formatTime(currentTime, "ss")
        }
    }

    // Main clock container
    Item {
        anchors.centerIn: parent
        width: 500
        height: 500

        // Glassmorphism clock face background
        Rectangle {
            id: clockFace
            anchors.centerIn: parent
            width: 420
            height: 420
            radius: 210
            color: "#FFFFFF"
            opacity: 0.7
            border.color: "#E5E5E7"
            border.width: 2
            
            // Shadow layers for depth
            Rectangle {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 8
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: "#00000015"
                z: -3
            }
            
            Rectangle {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 4
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: "#00000010"
                z: -2
            }

            // Inner frosted ring
            Rectangle {
                anchors.centerIn: parent
                width: 380
                height: 380
                radius: 190
                color: "transparent"
                border.color: "#0A84FF"
                border.width: 1
                opacity: 0.3
            }
        }

        // Digital time display
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 24

            // Main time display
            Controls.Label {
                id: clockLabel
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 72
                font.bold: true
                font.family: "SF Pro Display"
                color: "#1D1D1F"
                text: Qt.formatTime(new Date(), "hh:mm:ss")
            }

            // Seconds display with accent color
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: secondsLabel.width + 32
                height: secondsLabel.height + 16
                radius: 20
                color: "#0A84FF"
                opacity: 0.9

                Controls.Label {
                    id: secondsLabel
                    anchors.centerIn: parent
                    font.pixelSize: 24
                    font.bold: true
                    font.family: "SF Pro Display"
                    color: "#FFFFFF"
                    text: Qt.formatTime(new Date(), "ss")
                }
            }

            // Date display
            Controls.Label {
                id: dateLabel
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 24
                color: "#6E6E73"
                text: Qt.formatDate(new Date(), "dddd, MMMM d, yyyy")
            }

            // Time zone with glassmorphism pill
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: timeZoneLabel.width + 24
                height: timeZoneLabel.height + 12
                radius: 16
                color: "#FFFFFF"
                opacity: 0.8
                border.color: "#E5E5E7"
                border.width: 1

                Controls.Label {
                    id: timeZoneLabel
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "#6E6E73"
                    text: "Local Time"
                }
            }
        }

        // Hour markers - Apple Watch style
        Repeater {
            model: 12
            Rectangle {
                x: clockFace.x + clockFace.width/2 + (clockFace.width/2 - 40) * Math.cos((index * 30 - 90) * Math.PI / 180) - width/2
                y: clockFace.y + clockFace.height/2 + (clockFace.height/2 - 40) * Math.sin((index * 30 - 90) * Math.PI / 180) - height/2
                width: index % 3 === 0 ? 6 : 3
                height: index % 3 === 0 ? 24 : 16
                color: "#0A84FF"
                opacity: index % 3 === 0 ? 0.8 : 0.4
                radius: width/2
            }
        }
    }

    // Elegant entrance animation
    Component.onCompleted: {
        clockFace.scale = 0
        clockFace.opacity = 0
        entranceAnimation.start()
    }

    ParallelAnimation {
        id: entranceAnimation
        
        NumberAnimation {
            target: clockFace
            property: "scale"
            from: 0
            to: 1
            duration: 800
            easing.type: Easing.OutBack
        }
        
        NumberAnimation {
            target: clockFace
            property: "opacity"
            from: 0
            to: 0.7
            duration: 600
            easing.type: Easing.OutCubic
        }
    }
}
