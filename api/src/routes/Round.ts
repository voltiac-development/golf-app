import express, { json } from 'express';
import { isAuthenticated } from '../app/Authentication.js';
import { getRecentRounds, getSpecificRound, startNewRound } from '../app/Round.js';
var router = express.Router();

router.post('/start', isAuthenticated, async (req, res, next) => {
    let { data, error } = await startNewRound(req['user'].id, req['body']['courseId'], req['body']['tees'], req['body']['players'], req['body']['holeType'], req['body']['qualifying']);

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

router.get('/recent', isAuthenticated, async (req, res, next) => {
    let { data, error } = await getRecentRounds(req['user'].id);

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

router.get('/:id', isAuthenticated, async (req, res, next) => {
    let { data, error } = await getSpecificRound(req['user'].id, req['params'].id);

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