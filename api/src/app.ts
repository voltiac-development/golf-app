import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import path from 'path';
import chalk from 'chalk';
import cookieParser from 'cookie-parser';

const app = express();
const whitelist = ['http://localhost:8081']

var corsOptions = {
    origin: function (origin, callback) {
        if (whitelist.indexOf(origin) !== -1 || !origin) {
          callback(null, true)
        } else {
          callback(new Error('Not allowed by CORS'))
        }
    },
    credentials: true,
    methods: 'GET, POST, DELETE, OPTIONS, PATCH, PUT'
}

app.use(cors(corsOptions))
app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());


import { getCurrentUserDetails } from './app/Profile.js';

app.use(async (req, res, next) => {
    try{
        req['user'] = (await getCurrentUserDetails(req.header('gc-auth'))).data;
    }catch(e){}
    next();
});


// * Import routes
import authentication from './routes/Authentication.js';
import profile from './routes/Profile.js';
import course from './routes/Course.js';
import friend from './routes/Friend.js';
import round from './routes/Round.js';

// * Enable routes
app.use("/auth", authentication);
app.use('/profile', profile);
app.use('/course', course);
app.use('/friend', friend);
app.use('/round', round);

/**
 * @api {get} / Request Server Status
 * @apiName GetServerStatus
 * @apiGroup Server
 * @apiVersion 0.1.0
 *
 * @apiSuccess {String} msg Status of the server.
 * @apiExample {json} Server Running
 *      Success 200 
 *      {
 *          "msg": "Running"
 *      }
 */
app.get("/", (req, res) => {
    res.json({
        "msg": "SERVER ONLINE",
        "at": Date.now()
    });
})

import { Server } from 'http';

var http = new Server(app);

import * as socket from './app/Socket.js';
socket.default(http, corsOptions);

// Enable API docs 
if (process.env.NODE_ENV.toUpperCase().trim() == "PRODUCTION") {
    app.use("/docs", express.static(path.join(path.resolve(), "doc/public")))
}
else {
    app.use("/docs", express.static(path.join(path.resolve(), "doc/private")))
}

http.listen(process.env.PORT, () => {
    console.clear();
    console.log(chalk.green(`Authentication service listening on`), chalk.hex("#ED7014").bold.italic(`http://localhost:${process.env.PORT}`))
    console.log(chalk.yellow("Running node as"), chalk.yellow.bold.underline.italic(process.env.NODE_ENV));
})