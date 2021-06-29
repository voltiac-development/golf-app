import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import path from 'path';
import chalk from 'chalk';
import cookieParser from 'cookie-parser';

const app = express();
app.use(cors());
app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// * Import routes
// import profile from './routes/Profile.js';
// import authentication from './routes/Authentication.js';

// * Enable routes
// app.use("/profile", profile);
// app.use("/auth", authentication);

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
        "msg": "Running"
    });
})

// Enable API docs 
if (process.env.NODE_ENV.toUpperCase().trim() == "PRODUCTION") {
    app.use("/docs", express.static(path.join(path.resolve(), "doc/public")))
}
else {
    app.use("/docs", express.static(path.join(path.resolve(), "doc/private")))
}

app.listen(process.env.PORT, () => {
    console.clear();
    console.log(chalk.green(`Authentication service listening on`), chalk.hex("#ED7014").bold.italic(`http://localhost:${process.env.PORT}`))
    console.log(chalk.yellow("Running node as"), chalk.yellow.bold.underline.italic(process.env.NODE_ENV));
})