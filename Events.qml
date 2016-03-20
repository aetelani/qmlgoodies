import QtQuick 2.5
import QtQuick.Window 2.2
import QtQml.StateMachine 1.0
import QtWebSockets 1.0
import "imp.js" as P

QtObject {
    id: ev
    // Game control events
    property variant gameInitData
    property variant gameEventCache : []
    property variant gameEventLog : []
    function getGameEvent() {
        if(gameEventCache.length === 0) {
            console.log("game event cache index error");
            return;
        }
        var event = gameEventCache.shift();
        gameEventLog.push(event);
        return event;
    }

    signal serverConnected
    signal joinGame(WebSocket socket)
    signal gameConnected
    signal exitGame

    signal setupGame(variant info)
    onSetupGame: {
        gameInitData = info;
        initDisplay();
    }

    signal processGameEvent(int id)
    signal gameEvent(variant gameEvents)
    onGameEvent: {
        gameEventCache.push(gameEvents)
        processGameEvent(gameEvents.roundId);
    }
    
    // Game basic events
    signal actions
    signal move
    signal radar
    signal cannon
    
    // bOt modes
    signal flee
    signal attack
    signal patrol
    
    // Fleet modes
    signal teamAttack
}
