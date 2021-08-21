import express from 'express';
import { isAuthenticated } from '../app/Authentication.js';
import { acceptRequest, declineRequest, deleteFriend, getAllFriends, getAllRequests, getSpecificFriend, requestNewFriend } from '../app/Friend.js';
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
router.get("/all", isAuthenticated, async (req, res, next) => {
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

router.get('/incoming', isAuthenticated, async (req, res, next) => {
    let { data, error } = await getAllRequests(req['user'].id);

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

router.get('/get/:id', isAuthenticated, async (req, res, next) => {
    let { data, error } = await getSpecificFriend(req['user'].id, req['params'].id);

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

router.post('/accept', isAuthenticated, async (req, res, next) => {
    let { data, error } = await acceptRequest(req['user'].id, req['body'].friendId);

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

router.post('/decline', isAuthenticated, async (req, res, next) => {
    let { data, error } = await declineRequest(req['user'].id, req['body'].friendId);

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

router.post('/add', isAuthenticated, async (req, res, next) => {
    console.log(req['body'])
    let { data, error } = await requestNewFriend(req['user'].id, req['body'].friend);

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
        error: "Unknown error"
    })
    next()
});

router.delete('/remove', isAuthenticated, async (req, res, next) => {
    let { data, error } = await deleteFriend(req['user'].id, req['body'].friendId);

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
        error: "Unknown error"
    })
    next()
});

export default router;