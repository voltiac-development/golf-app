import { Course } from "../interfaces/Course.js";
import { sql } from "./knex.js";

export async function fetchAllCourses(): Promise<{data: [Course], error: Error}> {
    let courseData = null, error = null;

    try {
        courseData = await sql<Course>('courses').select('*')
    } catch (e) {
        error = e;
    }

    return {
        data: courseData,
        error
    }
}