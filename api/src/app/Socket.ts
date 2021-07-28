import * as socket from 'socket.io'
import { getSpecificRound } from './Round.js';
import { validateJWT, GetIdFromSession } from './Session.js'

export default function (http, corsOptions) {
    var io = new socket.Server(http, {
        cors: {
            origin: "*",
            methods: ["GET", "POST"]
        }
    });
    io.on('connection', async (s) => {
        if(s.handshake.auth['gc-auth'] == null)
            s.disconnect();
        let jwt = s.handshake.auth['gc-auth'];
        let result = validateJWT(jwt);
        if(result.error != null) s.disconnect();
        let sessionData = await GetIdFromSession(result.data.jti);
        if(sessionData.error != null) s.disconnect();
        s.on('join_game', async (roundId) => {
            let roundData = await getSpecificRound(sessionData.data, roundId);
            if(roundData.error != null) s.disconnect();
            s.join(roundId);
            io.to(s.id).emit('init', roundData.data);
        });
        s.on('update_score', async (data) => {
            io.to(data['roundId']).emit('update', data);
        });
    });
}