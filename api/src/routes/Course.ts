import express from 'express';
import { isAuthenticated } from '../app/Authentication.js';
import { getAllCourses, getBusinessHours, getHoleLengths, getHoleValues, getSpecificCourse } from '../app/Course.js';
import { getSpecificCourseRounds } from '../app/Round.js';
var router = express.Router();

/**
 * @api {get} /course/all Get all courses
 * @apiName Get all courses
 * @apiGroup Courses
 * @apiVersion 0.1.0
 * 
 * @apiSuccess {Array} Courses Course information.
 * @apiExample {json} Course successfull
 *      Success 200 
 *      {
 *          [
 *              "name": "De Dorpswaard",
 *              "par": 72,
 *          ],
 *      }
 */
router.get("/all", async (req, res, next) => {
    let { data, error } = await getAllCourses();

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

router.get('/info/:id', async (req, res, next) => {
    const { data, error } = await getSpecificCourse(req.params.id);
    console.log(data, error)

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
 
router.get('/length/:id', async (req, res, next) => {
    const { data, error } = await getHoleLengths(req.params.id);

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

router.get('/hole/:id', async (req, res, next) => {
    const { data, error } = await getHoleValues(req.params.id);

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

router.get('/rounds/:courseId', isAuthenticated, async (req, res, next) => {
    const { data, error } = await getSpecificCourseRounds(req['user'].id, req.params.courseId);

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

router.get('/hours/:courseId', async (req, res, next) => {
    const { data, error } = await getBusinessHours(req.params.courseId);

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