import express, { json } from 'express';
import { startNewRound } from '../app/Round.js';
var router = express.Router();
import JSON5 from 'json5';

router.post('/start', async (req, res, next) => {
    let body = req['body'];
    body['players'] = body['players'].replace("[", "").replace("]", "").split(', ')
    let { data, error } = await startNewRound(req['user'].id, body['courseId'], JSON.parse(body['tees']), body['players'], body['holeType']);

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