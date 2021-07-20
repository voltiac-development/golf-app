import express, { json } from 'express';
import { startNewRound } from '../app/Round.js';
var router = express.Router();
import JSON5 from 'json5';

router.post('/start', async (req, res, next) => {
    let { data, error } = await startNewRound(req['user'].id, req['body']['courseId'], req['body']['tees'], req['body']['players'], req['body']['holeType']);

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