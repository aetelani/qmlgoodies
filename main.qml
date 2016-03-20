import QtQuick 2.5
import QtQuick.Window 2.2
import QtQml.StateMachine 1.0
import QtWebSockets 1.0
import "imp.js" as P

Window {
    id: win
    visible: true
    height: 14 * 20 + 10 + 14 * 2
    width: 14 * 20 + 10 + 14 * 2
    Socket {
        id: socket
    }
    Events {
        id: events
    }

    Game {
        id: game
    }

    Column {
        id: colPos
        spacing: 2
        Repeater {
            id: colRepeat
            model: 14
            onItemAdded: {
                if(index % 2 === 0) {
                    console.log(itemAt(index).data[0].visible = false);
                }
            }
            Row { id: rowa
                spacing: 2
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    model: 14
                    onItemAdded: {
                        if(index % 2 === 0) {
                            //console.log(itemAt(index).color = "red");
                            // remove every other from first and last row.
                        }
                    }
                    Rectangle { width: 20; height: 20; color: "black" }
                }
            }
        }
    }

    /*MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            Qt.quit();
        }
    }*/
}
