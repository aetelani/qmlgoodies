import QtQuick 2.5
import QtQuick.Window 2.2
import QtQml.StateMachine 1.0
import QtWebSockets 1.0
import "imp.js" as P

StateMachine {
    id: sm
    initialState: connecting
    running: true
    signal exitGame
    State {
        id: connecting
        initialState: connectingServer
        State {
            id: connectingServer
            onEntered: {
                P.connectToServer(socket);
            }
            SignalTransition {
                signal: events.serverConnected;
                targetState: connectingGame
            }
        }
        State {
            id: connectingGame
            onEntered: P.connectToGame(socket);
            SignalTransition {
                signal: events.setupGame
                onTriggered: console.log('setupGame:' + info)
            }

            SignalTransition {
                targetState: running
                signal: events.gameConnected
            }
        }
    }
    
    State {
        id: running
        initialState: listeningEvents
        onEntered: console.log("to running state");
        State {
            id: listeningEvents
            onEntered: console.log("Listeting events");

            SignalTransition {
                signal: events.processGameEvent
                onTriggered: console.log('gameEvents:' + events.getGameEvent())
            }
            SignalTransition {
                targetState: exiting
                signal: events.exitGame
            }
        }
    }
    FinalState {
        id: exiting
        onEntered: console.log("exiting")
    }
    onFinished: P.exitGame();
}
