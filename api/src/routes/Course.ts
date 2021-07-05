import express from 'express';
import { getAllCourses } from '../app/Course.js';
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

export default router;