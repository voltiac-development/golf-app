import express from 'express';
import { login, register } from '../app/Authentication.js';
var router = express.Router();

/**
 * @api {post} /auth/login Login to account
 * @apiName Login
 * @apiGroup Authentication
 * @apiVersion 0.1.0
 *
 * @apiParam {String} email Users email.
 * @apiParam {String} password Users password.
 * 
 * @apiSuccess {String} jwtToken Authentication token.
 * @apiSuccess {Object} userData Data related to the user.
 * @apiExample {json} Login Successful
 *      Success 200 
 *      {
 *          "jwtToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
 *          "userData": {
 *              "username": "JohnDoe",
 *              "avatar": "https://via.placeholder.com/150",
 *              "accessLevel": "user"
 *          }
 *      }
 */
router.post("/login", async (req, res, next) => {
    let { data, error } = await login(req.body["email"], req.body["password"]);

    if (error) {
        res.status(error.getStatusCode());
        res.json(error.getErrorMessage());
        return;
    }

    if (data) {
        res.json(data);
        return;
    }

    res.status(500)
    res.json({
        error: "Unkown error"
    })
});

/**
 * @api {post} /auth/register Register account
 * @apiName Register
 * @apiGroup Authentication
 * @apiVersion 0.1.0
 *
 * @apiParam {String} email Users email.
 * @apiParam {String} name Users name.
 * @apiParam {String} password Users password.
 * @apiParam {String} password_verify Users password.
 * 
* @apiError (Error 409 Conflict) error Error message.
 * @apiErrorExample {json} Auth Cookie invalid
 *      Error 409: Conflict
 *      {
 *         "error": "A user exists with your email."
 *      }
 */
router.post("/register", async (req, res, next) => {
    let { data, error } = await register(req.body["email"], req.body["name"], req.body["password"], req.body["password_verify"], req.body["fav_course"]);

    if (error) {
        res.status(error.getStatusCode());
        res.json(error.getErrorMessage());
        return;
    }

    if (data) {
        res.json(data);
        return;
    }

    res.status(500)
    res.json({
        error: "Unkown error"
    })
})

export default router;