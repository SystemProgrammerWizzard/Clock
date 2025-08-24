import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2 as Kirigami

Kirigami.ScrollablePage {
    title: "Alarms"
    
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#F8F9FA" }
            GradientStop { position: 1.0; color: "#F5F5F7" }
        }
    }
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 320
            height: 280
            radius: 32
            color: "#FFFFFF"
            opacity: 0.8
            border.color: "#E5E5E7"
            border.width: 1
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 24
                
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 100
                    height: 100
                    radius: 50
                    color: "#FF453A"
                    opacity: 0.9
                    
                    Controls.Label {
                        anchors.centerIn: parent
                        text: "⏰"
                        font.pixelSize: 48
                    }
                }
                
                Controls.Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Alarms"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#1D1D1F"
                }
                
                Controls.Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Coming Soon"
                    font.pixelSize: 18
                    color: "#6E6E73"
                }
            }
        }
        
        Controls.Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: 400
            text: "Wake up on time with customizable alarms and snooze options."
            font.pixelSize: 16
            color: "#8E8E93"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
