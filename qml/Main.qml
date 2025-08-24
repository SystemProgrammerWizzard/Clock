import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    width: 900
    height: 700
    visible: true
    title: qsTr("Clock")
    
    property int currentTabIndex: 0
    property var accentColors: ["#0A84FF", "#30D158", "#FF9F0A", "#FF453A"]
    property string currentAccent: accentColors[currentTabIndex]

    // macOS-style background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#F8F9FA" }
            GradientStop { position: 1.0; color: "#F5F5F7" }
        }
    }

    // Top navigation - macOS segmented control style
    header: Item {
        height: 100
        
        // Navigation container with glassmorphism effect
        Rectangle {
            anchors.centerIn: parent
            width: 480
            height: 56
            radius: 28
            color: "#FFFFFF"
            opacity: 0.8
            border.color: "#E5E5E7"
            border.width: 1
            
            // Subtle shadow
            Rectangle {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 2
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: "#00000010"
                z: -1
            }
            
            // Tab buttons row
            Row {
                anchors.fill: parent
                anchors.margins: 4
                
                // Active tab indicator (sliding pill)
                Rectangle {
                    id: activeIndicator
                    width: parent.width / 4
                    height: parent.height - 8
                    y: 4
                    radius: 22
                    color: root.currentAccent
                    opacity: 0.9
                    
                    Behavior on x {
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                    }
                    
                    Behavior on color {
                        ColorAnimation { duration: 250 }
                    }
                }
                
                // Tab buttons
                Repeater {
                    model: [
                        { icon: "🌍", text: "World Clock", page: "WorldClock.qml" },
                        { icon: "⏳", text: "Timers", page: "Timers.qml" },
                        { icon: "⏱️", text: "Stopwatch", page: "StopWatch.qml" },
                        { icon: "⏰", text: "Alarms", page: "Alarms.qml" }
                    ]
                    
                    Item {
                        width: parent.width / 4
                        height: parent.height
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                root.currentTabIndex = index
                                activeIndicator.x = index * (parent.width)
                                stackView.replace("qrc:/qml/" + modelData.page)
                            }
                            
                            Column {
                                anchors.centerIn: parent
                                spacing: 4
                                
                                Controls.Label {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: modelData.icon
                                    font.pixelSize: 18
                                    opacity: root.currentTabIndex === index ? 1.0 : 0.6
                                    
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }
                                }
                                
                                Controls.Label {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: modelData.text
                                    font.pixelSize: 12
                                    font.family: "SF Pro Display, Inter, -apple-system, system-ui"
                                    color: root.currentTabIndex === index ? "#FFFFFF" : "#1D1D1F"
                                    
                                    Behavior on color {
                                        ColorAnimation { duration: 200 }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Content area
    Kirigami.PageRow {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: 20
        initialPage: Qt.resolvedUrl("WorldClock.qml")
    }
    
    // Initialize active indicator position
    Component.onCompleted: {
        activeIndicator.x = 0
    }
}