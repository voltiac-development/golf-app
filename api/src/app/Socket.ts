import * as socket from 'socket.io'


export default function (http, corsOptions) {
    var io = new socket.Server(http, {
        cors: corsOptions
    });
    io.sockets.on('connection', (s) => {
        console.log(s);
    })
}