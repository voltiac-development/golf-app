import express from 'express';
import { getAllFriends } from '../app/Friend.js';
import { HTTPError } from '../errors/HTTPError.js';
var router = express.Router();

/**
 * @api {get} /friend/all Get all friends
 * @apiName Get all friends
 * @apiGroup Friends
 * @apiVersion 0.1.0
 * 
 * @apiSuccess {Array} Friends All friends information.
 * @apiExample {json} Friends successfull
 *      Success 200 
 *      {
 *          [
 *              "id": "1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9",
 *              "name": "Bart Vermeulen",
 *              "handicap": 23.2,
 *              "image": "https://cdn.bartverm.dev/golfcaddie/user/1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9"
 *          ],
 *      }
 */
router.get("/all", async (req, res, next) => {
    let { data, error } = await getAllFriends(req['user'].id);

    if (error) {
        res.status(error.getStatusCode());
        res.json(error.getErrorMessage());
        next()
        return;
    }

    if (data) {
        res.json(data);
        next()
        return;
    }

    res.status(500)
    res.json({
        error: "Unkown error"
    })
    next()
});

export default router;