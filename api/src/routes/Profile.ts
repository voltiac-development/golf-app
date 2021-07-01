import express from 'express';
import { getCurrentUserDetails } from '../app/Profile.js';
var router = express.Router();

/**
 * @api {get} /profile/me Get account information of currently logged in account
 * @apiName GetMyAccountInfo
 * @apiDescription Get account information of currently logged in account. </br> Requires auth cookie: <code>VOLTIAC.AUTH</code> to be set
 * @apiGroup Profile
 * @apiVersion 0.1.0
 * 
 * @apiSuccess (Success 200) {String} msg Message
 * @apiSuccessExample {String} 200
 *      Hey
 * 
 * @apiError (Error 401) error Error message
 * @apiErrorExample {json} Auth Cookie not set
 *      Error 401: Unauthorized
 *      {
 *         "error": "'VOLTIAC.AUTH' cookie is not set."
 *      }
 * 
 * @apiError (Error 403) error Error message
 * @apiErrorExample {json} Auth Cookie invalid
 *      Error 403: Forbidden
 *      {
 *         "error": "'VOLTIAC.AUTH' cookie is not valid."
 *      }
 */
router.get("/me", async (req, res, next) => {
    let { data, error } = await getCurrentUserDetails(req.cookies["VOLTIAC.AUTH"]);

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

export default router;