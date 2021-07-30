import { Course, RoundTypes } from "../interfaces/Course.js";
import { sql } from "./knex.js";

export async function fetchAllCourses(): Promise<{data: [object], error: Error}> {
    let courseData = null, error = null;

    try {
        courseData = await sql<Course>('courses').select('*')
    } catch (e) {
        console.log(e)
        error = e;
    }

    return {
        data: courseData,
        error
    }
}

export async function fetchSpecificCourse(courseId: string): Promise<{data: Course, error: Error}> {
    let courseData = null, error = null, data = null;

    try {
        courseData = await sql<Course>('courses').select('*').where({id: courseId});
        if(courseData.length > 0){
            data = courseData[0]
        }
        else{
            error = new Error('f');
        }
    } catch (e) {
        error = e;
    }

    return {
        data: data,
        error
    }
}

export async function fetchRoundTypes(courseId: string): Promise<{data: RoundTypes[], error: Error}> {
    let courseData = null, error = null;

    try {
        courseData = await sql<RoundTypes>('roundTypes').select('*').where({courseId: courseId});
    } catch (e) {
        error = e;
    }

    return {
        data: courseData,
        error
    }
}

export async function fetchHoleLengths(courseId: string): Promise<{data: object[], error: Error}> {
    let courseData = null, error = null;

    try {
        courseData = await sql('holeLengths').select('*').where({courseId: courseId});
    } catch (e) {
        console.log(e);
        error = e;
    }

    return {
        data: courseData,
        error
    }
}